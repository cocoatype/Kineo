//  Created by Geoff Pado on 8/12/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

struct ReleaseNotesItem: StandardContentItem {
    let title = NSLocalizedString("SettingsContentProvider.Item.releaseNotes", comment: "Title for the release notes settings item")
    var subtitle: String? { String(format: Self.subtitleFormat, versionString) }

    private var versionString: String {
        let infoDictionary = Bundle.main.infoDictionary
        let versionString = infoDictionary?["CFBundleShortVersionString"] as? String
        return versionString ?? "???"
    }

    func performSelectedAction(_ sender: Any) {
        UIApplication.shared.sendAction(#selector(SettingsNavigationController.presentReleaseNotesController), to: nil, from: sender, for: nil)
    }

    private static let subtitleFormat = NSLocalizedString("ReleaseNotesItem.subtitleFormat", comment: "Format string for the subtitle of the release notes settings icon")
}
