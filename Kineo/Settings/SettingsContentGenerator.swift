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

    var content: some View {
        Group {
//            Section {
//                if purchaseState != .purchased {
//                    PurchaseNavigationLink(state: purchaseState, destination: PurchaseMarketingView())
//                }
//
//                if purchaseState != .purchased && hideAutoRedactions == false {
//                    SettingsAlertButton("SettingsContentProvider.Item.autoRedactions")
//                }
//
//                if purchaseState == .purchased {
//                    SettingsNavigationLink("SettingsContentProvider.Item.autoRedactions", destination: AutoRedactionsEditView().background(Color.appPrimary.edgesIgnoringSafeArea(.all)))
//                }
//            }
//
            Section(header: SettingsSectionHeader("SettingsContentProvider.Section.webURLs.header")) {
                WebURLButton("SettingsContentProvider.Item.new", "\(String(format: Self.versionStringFormat, versionString))", path: "releases")
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
        }
    }

    private static let versionStringFormat = NSLocalizedString("SettingsContentGenerator.versionStringFormat", comment: "Format string for the app version in Settings")
//    @Defaults.Value(key: .hideAutoRedactions) private var hideAutoRedactions: Bool
}
