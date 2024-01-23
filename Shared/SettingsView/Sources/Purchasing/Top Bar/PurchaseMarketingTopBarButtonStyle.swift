//  Created by Geoff Pado on 4/18/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import SwiftUI

@available(iOS 15, *)
struct PurchaseMarketingTopBarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        AnyView(configuration.label)
            .font(.appFont(for: .body).weight(.semibold))
            .foregroundColor(.white)
            .padding(8)
            .background(content: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(fillStyle(isPressed: configuration.isPressed))
                    .shadow(color: Asset.purchaseMarketingButtonShadowLight.swiftUIColor, radius: 10, x: 0, y: -5)
                    .shadow(color: Asset.purchaseMarketingButtonShadowDark.swiftUIColor, radius: 10, x: 0, y: 5)
            })
    }

    private func fillStyle(isPressed: Bool) -> some ShapeStyle {
        if isPressed {
            return LinearGradient(colors: [Asset.purchaseMarketingButtonPressedGradientDark.swiftUIColor, Asset.purchaseMarketingButtonPressedGradientLight.swiftUIColor], startPoint: .top, endPoint: .bottom)
        } else {
            return LinearGradient(colors: [Asset.purchaseMarketingTopBarBackground.swiftUIColor, Asset.purchaseMarketingTopBarBackground.swiftUIColor], startPoint: .top, endPoint: .bottom)
        }
    }
}

@available(iOS 15, *)
extension View {
    public func purchaseMarketingStyle() -> some View {
        return self.buttonStyle(PurchaseMarketingTopBarButtonStyle())
    }
}
