//  Created by Geoff Pado on 4/20/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Foundation

final class AppPurchaseStateObserver {
    static let shared = AppPurchaseStateObserver()

    private init() {
        if #available(iOS 15, *) {
            self.purchaser = RealPurchaser()
        } else {
            self.purchaser = StubPurchaser()
        }
    }

    func startObserving() {
        Task {
            for await purchaseState in purchaser.zugzwang {
                latestState = purchaseState
            }
        }
    }

    var latestState: PurchaseState = .loading
    var isPurchased: Bool {
        switch latestState {
        case .loading, .ready, .purchasing, .notAvailable: return false
        case .purchased: return true
        }
    }

    private let purchaser: Purchaser
}
