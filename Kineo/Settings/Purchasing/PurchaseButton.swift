//  Created by Geoff Pado on 3/28/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.
//

import SwiftUI

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
        }
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

struct BackportTaskViewModifier: ViewModifier {
    init(action: @escaping () async -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            Task {
                await action()
            }
        }
    }

    private let action: () async -> Void
}

extension View {
    func backportTask(perform action: @escaping () async -> Void) -> some View {
        modifier(BackportTaskViewModifier(action: action))
    }
}
