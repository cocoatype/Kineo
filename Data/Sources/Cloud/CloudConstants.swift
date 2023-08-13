//  Created by Geoff Pado on 2/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CloudKit

enum CloudConstants {
    static let containerID = "iCloud.com.flipbookapp.flickbook"
    static let documentRecordType = "Document"
    static let recordZoneID = CKRecordZone.ID(zoneName: recordZoneName, ownerName: CKCurrentUserDefaultName)
    static let recordZoneName = "CloudConstants.documentRecordZoneName"

    enum Fields {
        static let data = "data"
        static let identifier = "identifier"
    }
}
