//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

struct PurchaseItem: StandardContentItem {
//    let purchaser = StubPurchaser.purchaser()

    let title = NSLocalizedString("SettingsContentProvider.Item.purchase", comment: "Title for the purchase settings item")
    let subtitle: String? = nil
    func performSelectedAction(_ sender: Any) {
//        Task {
//            do {
//                try await purchaser.initiatePurchase()
//                print("success!")
//            } catch {
//                print("error: \(error.localizedDescription)")
//            }
//        }
    }
}
