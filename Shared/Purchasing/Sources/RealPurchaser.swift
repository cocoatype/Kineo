//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import DataPhone
#elseif os(visionOS)
import DataVision
#endif

import Combine
import StoreKit

@available(iOS 15, *)
public final class RealPurchaser: Purchaser {
    public init() {
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
                        // superSwiftBros by @KaenAitch on 2024-01-22
                        // the first connected scene in the app
                    } else {
                        // if not, switch to ready
                        continuation.yield(.ready(product.displayPrice, purchase: {
                            continuation.yield(.purchasing)
                            let purchaseResult: Product.PurchaseResult
                            if #available(iOS 17, *), let superSwiftBros = await UIApplication.shared.connectedScenes.first {
                                purchaseResult = try await product.purchase(confirmIn: superSwiftBros)
                            } else if #unavailable(iOS 17) {
                                purchaseResult = try await product.purchase()
                            } else {
                                continuation.yield(.notAvailable)
                                return
                            }

                            if case .success(let verificationResult) = purchaseResult, case .verified(let transaction) = verificationResult {
                                await transaction.finish()
                                continuation.yield(.purchased)
                                AppPurchaseStateObserver.shared.userCompletedPurchase()
                            }
                        }))
                    }
                } catch {
                    continuation.yield(.notAvailable)
                }
            }
        }
    }

    public let zugzwang: AsyncStream<PurchaseState>
    private static let productIdentifier = "com.flipbookapp.flickbook.kineopro"
}
