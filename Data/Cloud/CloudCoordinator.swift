//  Created by Geoff Pado on 2/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CloudKit
import os.log

public class CloudCoordinator: NSObject {
    public func performSync() {
        let syncOperation = CloudSyncOperation(database: database) { [weak self] result in
            NotificationCenter.default.post(name: CloudCoordinator.syncDidComplete, object: self)

            switch result {
            case .success: break
            case .failure(let error):
                CloudCoordinator.log("Error syncing: %@", error.localizedDescription)
            }
        }

        syncQueue.addOperation(syncOperation)
    }

    // MARK: Logging

    private static let log = OSLog(subsystem: "com.flipbookapp.flickbook.Data", category: "Cloud Sync")
    private static func log(_ text: StaticString, type: OSLogType = .default, _ args: CVarArg...) {
        os_log(text, log: CloudCoordinator.log, type: type, args)
    }

    // MARK: Notifications

    public static let syncDidComplete = Notification.Name("CloudCoordinator.syncDidComplete")

    // MARK: Boilerplate

    private let database = CKContainer(identifier: CloudConstants.containerID).privateCloudDatabase
    private let syncQueue = CloudSyncQueue()
}

class CloudSyncQueue: OperationQueue {
    public override init() {
        super.init()
        qualityOfService = .userInitiated
    }
}
