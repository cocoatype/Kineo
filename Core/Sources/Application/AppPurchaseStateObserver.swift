//  Created by Geoff Pado on 4/20/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Data
import Foundation

public final class AppPurchaseStateObserver {
    public static let shared = AppPurchaseStateObserver()

    private init() {
        if #available(iOS 15, *) {
            self.purchaser = RealPurchaser()
        } else {
            self.purchaser = StubPurchaser()
        }
    }

    public func startObserving() {
        Task {
            for await purchaseState in purchaser.zugzwang {
                latestState = purchaseState
            }
        }
    }

    func userCompletedPurchase() {
        latestState = .purchased
        Defaults.enablePurchasedSettings()
    }

    private(set) var latestState: PurchaseState = .loading
    var isPurchased: Bool {
        switch latestState {
        case .loading, .ready, .purchasing, .notAvailable: return false
        case .purchased: return true
        }
    }

    private let purchaser: Purchaser
}
