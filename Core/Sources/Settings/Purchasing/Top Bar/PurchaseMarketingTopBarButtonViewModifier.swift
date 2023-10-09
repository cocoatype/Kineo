//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import StylePhone
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
                    .fill(Asset.purchaseMarketingTopBarBackground.swiftUIColor)
                    .shadow(color: Asset.purchaseMarketingButtonShadowLight.swiftUIColor, radius: 10, x: 0, y: -5)
                    .shadow(color: Asset.purchaseMarketingButtonShadowDark.swiftUIColor, radius: 10, x: 0, y: 5)
            })
    }
}
