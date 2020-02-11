//  Created by Geoff Pado on 8/12/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

struct OtherAppItem: SettingsContentItem, IconProvidingContentItem {
    let appEntry: AppEntry
    var title: String { return appEntry.name }
    var subtitle: String? { appEntry.subtitle }
    var icon: UIImage? { appEntry.icon }

    func performSelectedAction(_ sender: Any) {
        guard let appStoreURL = appEntry.appStoreURL else { return }
        UIApplication.shared.open(appStoreURL)
    }
}

protocol IconProvidingContentItem: SettingsContentItem {
    var icon: UIImage? { get }
}
