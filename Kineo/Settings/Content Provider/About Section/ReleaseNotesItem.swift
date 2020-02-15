//  Created by Geoff Pado on 8/12/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

struct ReleaseNotesItem: StandardContentItem {
    let title = NSLocalizedString("SettingsContentProvider.Item.releaseNotes", comment: "Title for the release notes settings item")
    let subtitle: String? = "Version 20.0"

    func performSelectedAction(_ sender: Any) {
        UIApplication.shared.sendAction(#selector(SettingsNavigationController.presentReleaseNotesController), to: nil, from: sender, for: nil)
    }
}
