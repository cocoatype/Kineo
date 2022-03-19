//  Created by Geoff Pado on 8/12/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import StoreKit
import UIKit

struct OtherAppItem: SettingsContentItem, IconProvidingContentItem {
    let appEntry: AppEntry
    var title: String { return appEntry.name }
    var subtitle: String? { appEntry.subtitle }
    var icon: UIImage? { appEntry.icon }

    func performSelectedAction(_ sender: Any) {
        UIApplication.shared.sendAction(#selector(SettingsViewController.displayAppOverlay(_:event:)), to: nil, from: sender, for: AppOverlayEvent(appEntry.appleID))
    }
}

class AppOverlayEvent: UIEvent {
    let appleID: String

    init(_ appleID: String) {
        self.appleID = appleID
    }
}

protocol IconProvidingContentItem: SettingsContentItem {
    var icon: UIImage? { get }
}
