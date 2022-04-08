//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SafariServices
import SwiftUI

struct SettingsContentGenerator {
    private var versionString: String {
        let infoDictionary = Bundle.main.infoDictionary
        let versionString = infoDictionary?["CFBundleShortVersionString"] as? String
        return versionString ?? "???"
    }

    private let purchaser: Purchaser
    init() {
        if #available(iOS 15, *) {
            purchaser = RealPurchaser()
        } else {
            purchaser = StubPurchaser()
        }
    }

    var content: some View {
        Group {
            PurchaseButton(purchaser: purchaser)
            Section(header: SettingsSectionHeader("SettingsContentProvider.Section.webURLs.header")) {
                WebURLButton("SettingsContentProvider.Item.new", "SettingsContentGenerator.versionStringFormat\(versionString)", path: "releases")
                WebURLButton("SettingsContentProvider.Item.privacy", path: "privacy")
                WebURLButton("SettingsContentProvider.Item.acknowledgements", path: "acknowledgements")
                WebURLButton("SettingsContentProvider.Item.contact", path: "contact")
            }

            Section(content: {
                🐎IconToggleSwitch()
            })

            Section(header: SettingsSectionHeader("SettingsContentProvider.Section.otherApps.header")) {
                OtherAppButton(name: "Black Highlighter", subtitle: "Share pictures, not secrets", id: "1215283742")
                OtherAppButton(name: "Scrawl", subtitle: "definitely an app", id: "1229326968")
                OtherAppButton(name: "Debigulator", subtitle: "Shrink images to send faster", id: "1510076117")
            }

            Section(header: SettingsSectionHeader("SettingsContentProvider.Section.social.header")) {
                WebURLButton("SettingsContentProvider.Item.twitter", "SettingsContentProvider.Item.twitter.subtitle", path: "https://twitter.com/kineoapp")
                WebURLButton("SettingsContentProvider.Item.twitch", "SettingsContentProvider.Item.twitch.subtitle", path: "https://twitch.tv/cocoatype")
                WebURLButton("SettingsContentProvider.Item.instagram", "SettingsContentProvider.Item.instagram.subtitle", path: "https://instagram.com/kineoapp")
            }
        }
    }
}
