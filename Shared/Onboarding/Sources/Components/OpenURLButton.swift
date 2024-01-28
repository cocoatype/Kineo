//  Created by Geoff Pado on 1/28/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct OpenURLButton: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.dismiss) private var dismiss

    private let text: LocalizedStringKey
    private let url: URL

    init(text: LocalizedStringKey, url: URL) {
        self.text = text
        self.url = url
    }

    var body: some View {
        Button {
            openURL(url)
            dismiss()
        } label: {
            Text(text)
                .foregroundStyle(StyleAsset.tutorialIntroStartButtonTitle.swiftUIColor)
                .font(.appFont(for: .headline))
                .frame(maxWidth: .infinity)
        }
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(StyleAsset.tutorialIntroAccent.swiftUIColor)
        }
        .buttonBorderShape(.roundedRectangle(radius: 16))
    }
}
