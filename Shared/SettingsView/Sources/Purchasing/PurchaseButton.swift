//  Created by Geoff Pado on 3/28/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import PurchasingPhone
#elseif os(visionOS)
import PurchasingVision
#endif

import SwiftUI

@available(iOS 15, *)
struct PurchaseButton: View {
    @Binding private var purchaseState: PurchaseState// = PurchaseState.loading

    init(purchaseState: Binding<PurchaseState>) {
        _purchaseState = purchaseState
    }

    var body: some View {
        Button(title(for: purchaseState)) {
            Task {
                try await action(for: purchaseState)()
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
            PurchaseButton(purchaseState: .constant(.loading))
            PurchaseButton(purchaseState: .constant(.ready("$2.99", purchase: { })))
            PurchaseButton(purchaseState: .constant(.purchasing))
            PurchaseButton(purchaseState: .constant(.purchased))
        }
        VStack {
            PurchaseButton(purchaseState: .constant(.loading))
            PurchaseButton(purchaseState: .constant(.ready("$2.99", purchase: { })))
            PurchaseButton(purchaseState: .constant(.purchasing))
            PurchaseButton(purchaseState: .constant(.purchased))
        }.preferredColorScheme(.dark)
    }
}
