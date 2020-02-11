//  Created by Geoff Pado on 8/12/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

struct OtherAppItem: SettingsContentItem, IconProvidingContentItem {
    let appEntry: AppEntry
    var title: String { return appEntry.name }
    var subtitle: String? { appEntry.subtitle }
    let icon: UIImage? = nil

    func performSelectedAction(_ sender: Any) {
        (sender as? UIResponder)?.appEntryOpener?.openAppStore(displaying: appEntry)
    }
}

protocol IconProvidingContentItem: SettingsContentItem {
    var icon: UIImage? { get }
}
