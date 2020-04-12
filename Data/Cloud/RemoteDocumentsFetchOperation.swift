//  Created by Geoff Pado on 2/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CloudKit
import os.log

class RemoteDocumentsFetchOperation: ResultOperation<[Document], Error> {
    init(database: CKDatabase, completionHandler: ((OperationResult) -> Void)? = nil) {
        self.database = database
        super.init(completionHandler: completionHandler)
    }

    override func start() {
        let fetchOperationConfiguration = CKFetchRecordZoneChangesOperation.ZoneConfiguration(previousServerChangeToken: Defaults.serverChangeToken)
        let fetchOperation = CKFetchRecordZoneChangesOperation(recordZoneIDs: [CloudConstants.recordZoneID], configurationsByRecordZoneID: [CloudConstants.recordZoneID: fetchOperationConfiguration])

        fetchOperation.fetchRecordZoneChangesCompletionBlock = { [weak self] error in
            guard let operation = self else { return }
            if let error = error {
                Self.log("fetching documents failed with error: \(error.localizedDescription)")
                operation.fail(error: error)
            } else {
                Self.log("fetched new documents: \(operation.fetchedDocuments)")
                operation.succeed(value: operation.fetchedDocuments)
            }
        }

        fetchOperation.recordChangedBlock = { [weak self] record in
            self?.fetchedRecords.append(record)
        }

        fetchOperation.recordZoneFetchCompletionBlock = { _, token, _, _, _ in
            Defaults.serverChangeToken = token
        }

        fetchOperation.database = database
        syncQueue.addOperation(fetchOperation)
        super.start()
    }

    var fetchedDocuments: [Document] { fetchedRecords.compactMap { DocumentRecordTransformer.document(from: $0) }}

    // MARK: Logging

    private static let log = OSLog(subsystem: "com.flipbookapp.flickbook.Data", category: "Cloud Sync")
    private static func log(_ text: String, type: OSLogType = .default) {
        os_log("%@", log: Self.log, type: type, text)
    }

    // MARK: Boilerplate

    private let database: CKDatabase
    private var fetchedRecords = [CKRecord]()
    private let syncQueue = CloudSyncQueue()
}
