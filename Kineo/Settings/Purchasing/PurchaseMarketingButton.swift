//  Created by Geoff Pado on 4/18/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 15, *)
struct PurchaseMarketingButton: View {
    @State private var purchaseState = PurchaseState.loading
    @State private var selected = false
    init(purchaser: Purchaser) {
        self.purchaser = purchaser
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
        }.settingsCell().task {
            for await state in purchaser.zugzwang {
                dump(state)
                purchaseState = state
            }
        }
    }

    // MARK: Boilerplate

    private let purchaser: Purchaser
}

@available(iOS 15, *)
struct PurchaseMarketingButtonPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            PurchaseMarketingButton(purchaser: StubPurchaser())
        }.preferredColorScheme(.dark).previewLayout(.sizeThatFits)
    }
}
