//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

struct PurchaseSection: SettingsContentSection {
    var header: String? { return nil }
    var items: [SettingsContentItem] {
        return [
            PurchaseItem()
        ]
    }
}
