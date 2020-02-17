//  Created by Geoff Pado on 2/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CloudKit
import os.log

class CloudSyncOperation: ResultOperation<Void, Error> {
    init(database: CKDatabase, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        self.database = database
        super.init(completionHandler: completionHandler)
    }

    override func start() {
        let finalizeOperation: BlockOperation

        // save new documents
        let saveOperation = UnstoredDocumentsSaveOperation(database: database)

        // save updated documents

        // fetch remote documents
        let fetchOperation = RemoteDocumentsFetchOperation(database: database)
        fetchOperation.addDependency(saveOperation)

        // add an operation to the end of the queue to handle shutting down
        finalizeOperation = BlockOperation { [weak self] in
            if let fetchResult = fetchOperation.result, case .failure(let error) = fetchResult {
                self?.fail(error: error)
                return
            }

            self?.succeed()
        }
        finalizeOperation.addDependency(fetchOperation)

        // save any documents we receive from fetching
        fetchOperation.completionHandler = { [weak self] result in
            guard case .success(let documents) = result else { return }
            let saveOperation = DocumentSaveOperation(documents: documents)
            finalizeOperation.addDependency(saveOperation)
            self?.syncQueue.addOperation(saveOperation)
        }

        syncQueue.addOperations([saveOperation, fetchOperation, finalizeOperation], waitUntilFinished: false)

        super.start()
    }

    // MARK: Logging

    private static let log = OSLog(subsystem: "com.flipbookapp.flickbook.Data", category: "Cloud Sync")
    private static func log(_ text: String, type: OSLogType = .default) {
        os_log("%@", log: Self.log, type: type, text)
    }

    // MARK: Boilerplate

    private let database: CKDatabase
    private let syncQueue = CloudSyncQueue()
}
