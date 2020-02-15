//  Created by Geoff Pado on 2/10/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

struct TwitterItem: SettingsContentItem {
    let title = NSLocalizedString("SettingsContentProvider.Item.twitter", comment: "Title for the Twitter settings item")
    let subtitle: String? = NSLocalizedString("SettingsContentProvider.Item.twitter.subtitle", comment: "Subtitle for the Twitter settings item")

    func performSelectedAction(_ sender: Any) {
        guard let url = URL(string: "https://twitter.com/kineoapp") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
