//  Created by Geoff Pado on 1/28/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct BodyText: View {
    private let bodyText: LocalizedStringKey
    init(_ bodyText: LocalizedStringKey) {
        self.bodyText = bodyText
    }

    var body: some View {
        Text(bodyText)
            .foregroundStyle(StyleAsset.tutorialIntroText.swiftUIColor)
            .font(.appFont(for: .callout))
    }
}
