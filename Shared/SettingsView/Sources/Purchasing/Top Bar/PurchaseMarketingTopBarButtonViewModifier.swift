//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import SwiftUI

@available(iOS 15, *)
struct PurchaseMarketingTopBarButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        AnyView(content)
            .font(.appFont(for: .body).weight(.semibold))
            .foregroundColor(.white)
            .padding(8)
            .background(content: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(StyleAsset.purchaseMarketingTopBarBackground.swiftUIColor)
                    .shadow(color: StyleAsset.purchaseMarketingButtonShadowLight.swiftUIColor, radius: 10, x: 0, y: -5)
                    .shadow(color: StyleAsset.purchaseMarketingButtonShadowDark.swiftUIColor, radius: 10, x: 0, y: 5)
            })
    }
}
