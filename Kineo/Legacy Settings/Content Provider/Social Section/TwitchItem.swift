//  Created by Geoff Pado on 2/10/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

struct TwitchItem: SettingsContentItem {
    let title = NSLocalizedString("SettingsContentProvider.Item.twitch", comment: "Title for the Twitch settings item")
    let subtitle: String? = NSLocalizedString("SettingsContentProvider.Item.twitch.subtitle", comment: "Subtitle for the Twitch settings item")

    func performSelectedAction(_ sender: Any) {
        guard let url = URL(string: "https://twitch.tv/cocoatype") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
