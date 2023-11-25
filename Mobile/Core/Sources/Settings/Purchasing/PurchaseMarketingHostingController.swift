//  Created by Geoff Pado on 4/20/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI
import UIKit

@available(iOS 15, *)
class PurchaseMarketingHostingController: UIHostingController<HostedPurchaseMarketingView> {
    init() {
        super.init(rootView: HostedPurchaseMarketingView())
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

@available(iOS 15, *)
struct HostedPurchaseMarketingView: View {
    init() {
        self.purchaser = RealPurchaser()
    }

    var body: some View {
        PurchaseMarketingView(purchaseState: $purchaseState).task {
            for await purchaseState in purchaser.zugzwang {
                self.purchaseState = purchaseState
            }
        }
    }

    @State private var purchaseState: PurchaseState = .loading
    private let purchaser: Purchaser
}
