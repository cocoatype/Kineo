//  Created by Geoff Pado on 5/11/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import SafariServices

class WebViewController: SFSafariViewController {
    init(url: URL) {
        let configuration = SFSafariViewController.Configuration()
        super.init(url: url, configuration: configuration)

        modalPresentationStyle = .currentContext
        updateControlTintColor()
    }

    private func updateControlTintColor() {
        #if os(iOS)
        preferredControlTintColor = Asset.webControlTint.color
        #endif
    }

    private var isDarkMode: Bool { return traitCollection.userInterfaceStyle == .dark }

    private static let websiteBase = URL(string: "https://kineo.app")
    static func websiteURL(withPath path: String) -> URL? {
        return websiteBase?.appendingPathComponent(path)
    }
}
