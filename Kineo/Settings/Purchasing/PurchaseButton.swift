//  Created by Geoff Pado on 3/28/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 15, *)
struct PurchaseButton: View {
    @State private var purchaseState = PurchaseState.loading
    private var purchaser: Purchaser

    init(purchaser: Purchaser) {
        self.purchaser = purchaser
    }

    var body: some View {
        Button(title(for: purchaseState)) {
            Task {
                try await action(for: purchaseState)()
            }
        }.backportTask {
            for await newState in purchaser.zugzwang {
                purchaseState = newState
            }
        }.purchaseMarketingStyle()
    }

    private func title(for purchaseState: PurchaseState) -> LocalizedStringKey {
        switch purchaseState {
        case .loading:
            return "PurchaseButton.loadingTitle"
        case .ready(let displayPrice, _):
            return "PurchaseButton.readyTitle\(displayPrice)"
        case .purchasing:
            return "PurchaseButton.purchasingTitle"
        case .purchased:
            return "PurchaseButton.purchasedTitle"
        case .notAvailable:
            return "PurchaseButton.purchasedTitle"
        }
    }

    private func action(for purchaseState: PurchaseState) -> (() async throws -> Void) {
        switch purchaseState {
        case .ready(_, let purchase):
            return purchase
        default:
            return {}
        }
    }
}

@available(iOS 15, *)
struct PurchaseButtonPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            PurchaseButton(purchaser: StubPurchaser())
            PurchaseButton(purchaser: StubPurchaser(purchaseState: .ready("$2.99", purchase: { })))
            PurchaseButton(purchaser: StubPurchaser(purchaseState: .purchasing))
            PurchaseButton(purchaser: StubPurchaser(purchaseState: .purchased))
        }
        VStack {
            PurchaseButton(purchaser: StubPurchaser())
            PurchaseButton(purchaser: StubPurchaser(purchaseState: .ready("$2.99", purchase: { })))
            PurchaseButton(purchaser: StubPurchaser(purchaseState: .purchasing))
            PurchaseButton(purchaser: StubPurchaser(purchaseState: .purchased))
        }.preferredColorScheme(.dark)
    }
}
