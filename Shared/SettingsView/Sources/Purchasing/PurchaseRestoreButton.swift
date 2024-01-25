//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import StoreKit
import SwiftUI

@available(iOS 15, *)
struct PurchaseRestoreButton: View {
    var body: some View {
        Button("PurchaseRestoreButton.title") {
            Task {
                _ = try? await AppStore.sync()
            }
        }.purchaseMarketingStyle()
    }
}

@available(iOS 15, *)
struct PurchaseRestoreButtonPreviews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            PurchaseRestoreButton()
        }
        .fill()
        .background(StyleAsset.purchaseMarketingTopBarBackground.swiftUIColor)
    }
}
