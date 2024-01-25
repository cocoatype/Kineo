//  Created by Geoff Pado on 4/18/22.
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
struct PurchaseMarketingButton: View {
    @Binding private var purchaseState: PurchaseState
    @State private var selected = false
    init(purchaseState: Binding<PurchaseState>) {
        _purchaseState = purchaseState
    }

    var body: some View {
        Button(action: {
            selected = true
        }) {
            VStack(alignment: .leading) {
                PurchaseMarketingButtonTitle()
                PurchaseMarketingButtonSubtitle(purchaseState: $purchaseState)
            }
        }.sheet(isPresented: $selected) {
            PurchaseMarketingView(purchaseState: $purchaseState)
        }
        .listRowBackground(StyleAsset.purchaseMarketingTopBarBackground.swiftUIColor)
        .padding(.vertical, 8)
    }
}

@available(iOS 15, *)
struct PurchaseMarketingButtonPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            PurchaseMarketingButton(purchaseState: .constant(.loading))
            PurchaseMarketingButton(purchaseState: .constant(.ready("$4.99", purchase: {})))
        }.preferredColorScheme(.dark).previewLayout(.sizeThatFits)
    }
}
