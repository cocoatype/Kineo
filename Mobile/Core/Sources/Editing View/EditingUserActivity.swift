//  Created by Geoff Pado on 12/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import DataPhone
import Foundation

public class EditingUserActivity: NSUserActivity {
    public let document: Document

    public init(document: Document) {
        self.document = document
        super.init(activityType: Self.defaultActivityType)

        do {
            let documentData = try JSONEncoder().encode(document)
            userInfo = [EditingUserActivity.documentDataKey: documentData]
        } catch {}
    }

    public convenience init?(userActivity: NSUserActivity) {
        guard userActivity.activityType == EditingUserActivity.defaultActivityType, let documentData = (userActivity.userInfo?[EditingUserActivity.documentDataKey] as? Data), let document = try? JSONDecoder().decode(Document.self, from: documentData) else { return nil }

        self.init(document: document)
        title = userActivity.title
    }

    // MARK: Boilerplate

    private static let defaultActivityType = "com.flipbookapp.flickbook.editing"
    private static let documentDataKey = "EditingUserActivity.documentDataKey"
}
