//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import PurchasingPhone
import StylePhone
#elseif os(visionOS)
import PurchasingVision
import StyleVision
#endif

import SwiftUI

@available(iOS 15, *)
struct PurchaseMarketingTopBar: View {
    @Binding private var purchaseState: PurchaseState
    init(purchaseState: Binding<PurchaseState>) {
        _purchaseState = purchaseState
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 0) {
                PurchaseMarketingTopBarHeadline()
                PurchaseMarketingTopBarSubheadline()
            }
            HStack(spacing: 12) {
                PurchaseButton(purchaseState: $purchaseState)
                PurchaseRestoreButton()
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(StyleAsset.purchaseMarketingTopBarBackground.swiftUIColor)
    }
}

@available(iOS 15, *)
struct PurchaseMarketingTopBarPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            PurchaseMarketingTopBar(purchaseState: .constant(.loading)).preferredColorScheme(.dark)
            PurchaseMarketingTopBar(purchaseState: .constant(.loading))
        }.previewLayout(.sizeThatFits)
    }
}
