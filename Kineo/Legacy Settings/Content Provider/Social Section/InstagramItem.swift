//  Created by Geoff Pado on 2/10/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

struct InstagramItem: SettingsContentItem {
    let title = NSLocalizedString("SettingsContentProvider.Item.instagram", comment: "Title for the Instagram settings item")
    let subtitle: String? = NSLocalizedString("SettingsContentProvider.Item.instagram.subtitle", comment: "Subtitle for the Instagram settings item")

    func performSelectedAction(_ sender: Any) {
        guard let url = URL(string: "https://instagram.com/kineoapp") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
