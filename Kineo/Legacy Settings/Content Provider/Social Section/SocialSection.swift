//  Created by Geoff Pado on 2/10/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Foundation

struct SocialSection: SettingsContentSection {
    let header: String? = NSLocalizedString("SettingsContentProvider.Section.social.header", comment: "Header for the social media section")
    let items: [SettingsContentItem] = [
        TwitterItem(),
        InstagramItem(),
        TwitchItem()
    ]
}
