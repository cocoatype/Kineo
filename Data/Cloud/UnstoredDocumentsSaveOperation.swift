//  Created by Geoff Pado on 2/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CloudKit
import os.log

class UnstoredDocumentsSaveOperation: ResultOperation<Void, Error> {
    init(database: CKDatabase) {
        self.database = database
    }

    override func start() {
        let initialOperation = newQueryOperation()
        processIdentifiersOperation.addDependency(initialOperation)
        syncQueue.addOperations([initialOperation, processIdentifiersOperation], waitUntilFinished: false)
    }

    // MARK: Querying

    private func newQueryOperation(with cursor: CKQueryOperation.Cursor? = nil) -> CKQueryOperation {
        UnstoredDocumentsQueryOperation(database: database, cursor: cursor) { [weak self] records, cursor, error in
            guard let operation = self else { return }
            operation.fetchedRecords.append(contentsOf: records)

            if let error = error {
                Self.log("error querying for records: \(error.localizedDescription)", type: .error)

                if let cloudError = error as? CKError, cloudError.containsMissingRecordZoneError {
                    let createRecordZoneOperation = CreateRecordZoneOperation(database: operation.database)
                    let newQueryOperation = operation.newQueryOperation()
                    newQueryOperation.addDependency(createRecordZoneOperation)
                    operation.processIdentifiersOperation.addDependency(newQueryOperation)
                    operation.syncQueue.addOperations([createRecordZoneOperation, newQueryOperation], waitUntilFinished: false)
                } else {
                    operation.fail(error: error)
                }
                // check if it's a missing record zone error
                // if so, create the record zone
                // then retry the initial operation
            } else if let cursor = cursor {
                let newQueryOperation = operation.newQueryOperation(with: cursor)
                operation.processIdentifiersOperation.addDependency(newQueryOperation)
                operation.syncQueue.addOperation(newQueryOperation)
            }
        }
    }

    // MARK: Processing

    private lazy var processIdentifiersOperation = BlockOperation { [weak self] in
        guard let operation = self else { return }
        let documentStore = operation.documentStore

        let localIdentifiers = documentStore.allIdentifiers
        Self.log("Local identifiers: \(localIdentifiers)")

        let fetchedIdentifiers = operation.fetchedIdentifiers
        Self.log("Remote identifiers: \(fetchedIdentifiers)")

        let unstoredIdentifiers = localIdentifiers.filter { fetchedIdentifiers.contains($0) == false }
        Self.log("Unstored identifiers: \(unstoredIdentifiers)")

        let documentRecords = unstoredIdentifiers.compactMap { try? DocumentRecordTransformer.record(from: documentStore.document(with: $0)) }
        Self.log("Saving records: \(documentRecords.map { $0[CloudConstants.Fields.identifier]})")

        let modifyOperation = CKModifyRecordsOperation(recordsToSave: documentRecords, recordIDsToDelete: nil)
        modifyOperation.database = operation.database
        modifyOperation.savePolicy = .allKeys
        modifyOperation.modifyRecordsCompletionBlock = { [weak self] _, _, error in
            if let error = error {
                Self.log("Modifying records failed with error: \(error.localizedDescription)")
                self?.fail(error: error)
            } else {
                Self.log("Modifying records succeeded")
                self?.succeed()
            }
        }

        operation.syncQueue.addOperation(modifyOperation)
    }

    private var fetchedIdentifiers: [UUID] {
        fetchedRecords
          .compactMap { $0[CloudConstants.Fields.identifier] as? String }
          .compactMap(UUID.init(uuidString:))
    }

    // MARK: Logging

    private static let log = OSLog(subsystem: "com.flipbookapp.flickbook.Data", category: "Cloud Sync")
    private static func log(_ text: String, type: OSLogType = .default) {
        os_log("%@", log: Self.log, type: type, text)
    }

    // MARK: Boilerplate

    private let database: CKDatabase
    private let documentStore = DocumentStore()
    private var fetchedRecords = [CKRecord]()
    private let syncQueue = CloudSyncQueue()
}

private extension CKError {
    var recordZonePartialErrors: [CKError]? {
        return partialErrorsByItemID?
          .filter { $0.0 is CKRecordZone.ID }
          .values
          .compactMap { $0 as? CKError }
    }

    var containsMissingRecordZoneError: Bool {
        guard code != .zoneNotFound else { return true }
        guard let errors = recordZonePartialErrors else { return false }
        return errors.contains(where: { $0.code == .zoneNotFound })
    }
}

class CreateRecordZoneOperation: CKModifyRecordZonesOperation {
    init(database: CKDatabase) {
        let newRecordZone = CKRecordZone(zoneID: CloudConstants.recordZoneID)
        super.init()
        self.recordZonesToSave = [newRecordZone]
        self.database = database
        self.modifyRecordZonesCompletionBlock = { _, _, error in
            if let error = error {
                Self.log("Error creating record zone: \(error)", type: .error)
            } else {
                Self.log("Successfully created record zone")
            }
        }
    }

    // MARK: Logging

    private static let log = OSLog(subsystem: "com.flipbookapp.flickbook.Data", category: "Cloud Sync")
    private static func log(_ text: String, type: OSLogType = .default) {
        os_log("%@", log: Self.log, type: type, text)
    }
}
