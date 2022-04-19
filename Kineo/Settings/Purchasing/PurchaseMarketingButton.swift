//  Created by Geoff Pado on 4/18/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

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
                WebURLTitleText("PurchaseMarketingButton.title")
                if case let PurchaseState.ready(price, _) = purchaseState {
                    WebURLSubtitleText("PurchaseMarketingButton.subtitle\(price)")
                } else {
                    WebURLSubtitleText("PurchaseMarketingButton.subtitle")
                }
            }
        }.sheet(isPresented: $selected) {
            PurchaseMarketingView(purchaseState: $purchaseState)
        }.settingsCell()
    }
}

@available(iOS 15, *)
struct PurchaseMarketingButtonPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            PurchaseMarketingButton(purchaseState: .constant(.loading))
        }.preferredColorScheme(.dark).previewLayout(.sizeThatFits)
    }
}
