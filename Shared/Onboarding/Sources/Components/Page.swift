//  Created by Geoff Pado on 1/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import StyleVision
import SwiftUI

struct Page<Buttons: View>: View {
    private let bodyText: LocalizedStringKey
    private let buttons: () -> Buttons

    init(bodyText: LocalizedStringKey, @ViewBuilder buttons: @escaping () -> Buttons) {
        self.bodyText = bodyText
        self.buttons = buttons
    }

    var body: some View {
        StyleAsset.background.swiftUIColor
            .frame(width: 552.0, height: 715.0)
            .overlay {
                VStack(alignment: .leading, spacing: 16) {
                    Title()
                    BodyText(bodyText)
                }
                .padding(65)
            }
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        buttons()
                    }
                }.padding(32)
            }
    }
}

enum OnboardingViewPreviews: PreviewProvider {
    static var previews: some View {
        Page(bodyText: "Lorem ipsum dolor sit amet.") {}
    }
}
