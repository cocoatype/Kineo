//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct WebURLButton: View {
    @State private var selected = false
    init(_ titleKey: LocalizedStringKey, _ subtitleKey: LocalizedStringKey? = nil, path: String) {
        self.titleKey = titleKey
        self.subtitleKey = subtitleKey
        self.url = Self.url(forPath: path)
    }

    var body: some View {
        Button(action: {
            selected = true
        }) {
            VStack(alignment: .leading) {
                WebURLTitleText(titleKey)
                if let subtitle = subtitleKey {
                    WebURLSubtitleText(subtitle)
                }
            }
        }.sheet(isPresented: $selected) {
            WebView(url: url)
        }.settingsCell()
    }

    private static let baseURL = URL(string: "https://kineo.app/")

    private static func url(forPath path: String) -> URL {
        guard let url = URL(string: path, relativeTo: baseURL) else {
            fatalError("Invalid path for web URL: \(path)")
        }
        return url
    }

    // MARK: Boilerplate

    private let titleKey: LocalizedStringKey
    private let subtitleKey: LocalizedStringKey?
    private let url: URL
}

struct WebURLTitleText: View {
    private let key: LocalizedStringKey
    init(_ key: LocalizedStringKey) {
        self.key = key
    }

    var body: some View {
        Text(key)
            .font(.appFont(forTextStyle: .body))
            .foregroundColor(.primary)
    }
}

struct WebURLSubtitleText: View {
    private let key: LocalizedStringKey
    init(_ key: LocalizedStringKey) {
        self.key = key
    }

    var body: some View {
        Text(key)
            .font(.appFont(forTextStyle: .caption1))
            .foregroundColor(.primary)
    }
}


struct WebURLButtonPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            WebURLButton("Hello", path: "world")
            WebURLButton("Hello", "world!", path: "world")
        }.preferredColorScheme(.dark).previewLayout(.sizeThatFits)
    }
}
