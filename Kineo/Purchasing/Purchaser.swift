//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

protocol Purchaser {
    // zugzwang by @KaenAitch on 3/21/22
    // can a purchase be made?
    var zugzwang: Bool { get }
    func initiatePurchase() async throws
}

extension Purchaser {
    static func purchaser() -> Purchaser {
        if #available(iOS 15, *) {
            return RealPurchaser()
        } else {
            return StubPurchaser()
        }
    }
}
