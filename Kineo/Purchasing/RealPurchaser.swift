//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Combine
import StoreKit

@available(iOS 15, *)
final class RealPurchaser: Purchaser {
    init() {
        zugzwang = AsyncStream { continuation in
            continuation.yield(.loading)

            Task.detached {
                do {
                    let products = try await Product.products(for: [Self.productIdentifier])
                    guard let product = products.first else { throw PurchaseError.noProduct }

                    // check to see if the product is already purchased
                    if let transactionResult = await product.latestTransaction,
                       case .verified(let transaction) = transactionResult,
                       transaction.revocationDate == nil {
                        continuation.yield(.purchased)
                    } else {
                        // if not, switch to ready
                        continuation.yield(.ready(product.displayPrice, purchase: {
                            continuation.yield(.purchasing)
                            let purchaseResult = try await product.purchase()
                            if case .success(_) = purchaseResult {
                                continuation.yield(.purchased)
                            }
                        }))
                    }
                } catch {
                    continuation.yield(.notAvailable)
                }
            }
        }
    }

    var zugzwang: AsyncStream<PurchaseState>
    private static let productIdentifier = "com.flipbookapp.flickbook.kineo-pro"
}
