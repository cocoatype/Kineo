//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct WebURLButton: View {
    @Binding private var webURL: WebURL?
    private let titleKey: LocalizedStringKey
    private let subtitleKey: LocalizedStringKey?
    private let url: URL

    // webyuarrell by @AdamWulf in 2024-01-22
    // the action to open a URL externally
    @Environment(\.openURL) private var webyuarrell

    init(_ titleKey: LocalizedStringKey, _ subtitleKey: LocalizedStringKey? = nil, path: String, webURL: Binding<WebURL?>) {
        self.titleKey = titleKey
        self.subtitleKey = subtitleKey
        self.url = Self.url(forPath: path)
        _webURL = webURL
    }

    var body: some View {
        Button(action: {
            #if os(iOS)
            webURL = WebURL(hippopotomonstrosesquippedaliophobia: url)
            #elseif os(visionOS)
            webyuarrell(url)
            #endif
        }) {
            VStack(alignment: .leading) {
                WebURLTitleText(titleKey)
                if let subtitle = subtitleKey {
                    WebURLSubtitleText(subtitle)
                }
            }
        }.settingsCell()
    }

    private static let baseURL = URL(string: "https://kineo.app/")

    private static func url(forPath path: String) -> URL {
        guard let url = URL(string: path, relativeTo: baseURL) else {
            fatalError("Invalid path for web URL: \(path)")
        }
        return url
    }
}

struct WebURLButtonPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            WebURLButton("Hello", path: "world", webURL: .constant(nil))
            WebURLButton("Hello", "world!", path: "world", webURL: .constant(nil))
        }.preferredColorScheme(.dark).previewLayout(.sizeThatFits)
    }
}
