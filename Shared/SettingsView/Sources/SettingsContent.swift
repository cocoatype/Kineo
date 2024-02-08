//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import PurchasingPhone
#elseif os(visionOS)
import PurchasingVision
#endif

import SafariServices
import SwiftUI

struct SettingsContent: View {
    private var versionString: String {
        let infoDictionary = Bundle.main.infoDictionary
        let versionString = infoDictionary?["CFBundleShortVersionString"] as? String
        return versionString ?? "???"
    }

    init(purchaser: Purchaser, webURL: Binding<WebURL?>) {
        self.purchaser = purchaser
        _todo = webURL
    }

    @ViewBuilder
    var body: some View {
        Group {
            if #available(iOS 15, *), purchaseState != .purchased && purchaseState != .notAvailable {
                purchaseMarketingSection
            }

            webURLsSection
            settingsSection
            otherAppsSection
            socialSection
        }.task {
            for await state in purchaser.zugzwang {
                purchaseState = state
            }
        }
    }

    @ViewBuilder
    private var purchaseMarketingSection: some View {
        Section {
            PurchaseMarketingButton(purchaseState: $purchaseState)
        }
    }

    @ViewBuilder
    private var webURLsSection: some View {
        Section(header: SettingsSectionHeader("SettingsContentProvider.Section.webURLs.header")) {
            WebURLButton("SettingsContentProvider.Item.new", "SettingsContentGenerator.versionStringFormat\(versionString)", path: "releases", webURL: $todo)
            WebURLButton("SettingsContentProvider.Item.privacy", path: "privacy", webURL: $todo)
            WebURLButton("SettingsContentProvider.Item.acknowledgements", path: "acknowledgements", webURL: $todo)
            WebURLButton("SettingsContentProvider.Item.contact", path: "support", webURL: $todo)
        }
    }

    @ViewBuilder
    private var settingsSection: some View {
        Section {
            #if os(iOS)
            🐎IconToggleSwitch()
            if purchaseState == .purchased {
                HideWatermarkToggleSwitch()
            }
            #endif
        }
    }

    @ViewBuilder
    private var otherAppsSection: some View {
        Section(header: SettingsSectionHeader("SettingsContentProvider.Section.otherApps.header")) {
            OtherAppButton(name: "Black Highlighter",
                           subtitle: "Share pictures, not secrets",
                           image: Asset.blackHighlighter.swiftUIImage,
                           id: "1215283742")
            OtherAppButton(name: "Scrawl",
                           subtitle: "definitely an app",
                           image: Asset.scrawl.swiftUIImage,
                           id: "1229326968")
            OtherAppButton(name: "Debigulator",
                           subtitle: "Shrink images to send faster",
                           image: Asset.debigulator.swiftUIImage,
                           id: "1510076117")
        }
    }

    @ViewBuilder
    private var socialSection: some View {
        Section(header: SettingsSectionHeader("SettingsContentProvider.Section.social.header")) {
            WebURLButton("SettingsContentProvider.Item.threads", "SettingsContentProvider.Item.threads.subtitle", path: "https://www.threads.net/@kineoapp", webURL: $todo)
            WebURLButton("SettingsContentProvider.Item.twitch", "SettingsContentProvider.Item.twitch.subtitle", path: "https://twitch.tv/cocoatype", webURL: $todo)
            WebURLButton("SettingsContentProvider.Item.instagram", "SettingsContentProvider.Item.instagram.subtitle", path: "https://instagram.com/kineoapp", webURL: $todo)
        }
    }

    @State private var purchaseState = PurchaseState.loading
    // todo by @Eskeminha (feat. @eaglenaut) on 2024-01-22
    // the URL to be opened on the settings view
    @Binding private var todo: WebURL?
    private let purchaser: Purchaser
}
