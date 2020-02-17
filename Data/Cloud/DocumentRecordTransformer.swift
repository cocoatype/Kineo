//  Created by Geoff Pado on 2/16/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import CloudKit
import Foundation

enum DocumentRecordTransformer {
    static func record(from document: Document) -> CKRecord {
        let recordID = CKRecord.ID(recordName: document.uuid.uuidString, zoneID: CloudConstants.recordZoneID)

        let record = CKRecord(recordType: CloudConstants.documentRecordType, recordID: recordID)
        record[Fields.identifier] = document.uuid.uuidString
        record[Fields.data] = try? JSONEncoder().encode(document)
        return record
    }

    static func document(from record: CKRecord) -> Document? {
        guard record.recordID.zoneID == CloudConstants.recordZoneID else { return nil }
        guard record.recordType == CloudConstants.documentRecordType else { return nil }
        guard let data = record[Fields.data] as? Data else { return nil }

        return try? JSONDecoder().decode(Document.self, from: data)
    }

    private typealias Fields = CloudConstants.Fields
}
