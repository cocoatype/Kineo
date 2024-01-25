//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct OtherAppButton: View {
    private let name: String
    private let subtitle: String
    private let image: Image
    private let id: String

    init(name: String, subtitle: String, image: Image, id: String) {
        self.name = name
        self.subtitle = subtitle
        self.image = image
        self.id = id
    }

    private var url: URL {
        let urlString = "https://apps.apple.com/us/app/cocoatype/id\(id)?uo=4"
        guard let url = URL(string: urlString) else { fatalError("Invalid App Store URL: \(urlString)") }
        return url
    }

    var body: some View {
        Button(action: {
            UIApplication.shared.open(url)
        }, label: {
            HStack(spacing: 12) {
                image
                    .accessibilityHidden(true)
                    .continuousCornerRadius(5.6)
                VStack(alignment: .leading) {
                    OtherAppNameText(name)
                    OtherAppSubtitleText(subtitle)
                }
            }
        }).settingsCell()
    }
}

struct OtherAppButton_Previews: PreviewProvider {
    static var previews: some View {
        OtherAppButton(
            name: "Black Highlighter",
            subtitle: "Create flipbook-style animations",
            image: Asset.blackHighlighter.swiftUIImage,
            id: "286948844"
        )
        .preferredColorScheme(.light)
        .previewLayout(.sizeThatFits)

        OtherAppButton(
            name: "Debigulator",
            subtitle: "Create flipbook-style animations",
            image: Asset.debigulator.swiftUIImage,
            id: "286948844"
        )
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)

    }
}

