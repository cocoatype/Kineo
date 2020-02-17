//  Created by Geoff Pado on 2/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CloudKit

class UnstoredDocumentsQueryOperation: CKQueryOperation {
    init(database: CKDatabase, cursor: CKQueryOperation.Cursor? = nil, completionHandler: @escaping (([CKRecord], Cursor?, Error?) -> Void)) {
        self.completionHandler = completionHandler
        super.init()

        self.cursor = cursor
        self.query = remoteDocumentsQuery
        self.database = database
        self.desiredKeys = [CloudConstants.Fields.identifier]
        self.zoneID = CloudConstants.recordZoneID

        self.recordFetchedBlock = { [weak self] record in
            self?.fetchedRecords.append(record)
        }

        self.queryCompletionBlock = { [weak self] cursor, error in
            guard let operation = self else { return }
            operation.completionHandler?(operation.fetchedRecords, cursor, error)
        }
    }

    var fetchedRecords = [CKRecord]()

    // MARK: Boilerplate

    private let completionHandler: (([CKRecord], Cursor?, Error?) -> Void)?
    private let remoteDocumentsQuery = CKQuery(recordType: CloudConstants.documentRecordType, predicate: NSPredicate(value: true))
}
