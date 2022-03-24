//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import StoreKit

@available(iOS 15, *)
class RealPurchaser: Purchaser {
    var products: [Product]? = nil
    var productsTask: Task<Void, Never>? = nil
    var zugzwang: Bool { products != nil }

    init() {
        productsTask = Task { [weak self] in
            self?.products = try? await fetchProducts()
        }
    }

    func fetchProducts() async throws -> [Product] {
        return try await Product.products(for: [Self.productIdentifier])
    }

    func initiatePurchase() async throws {
        let currentProducts: [Product]
        if let products = products {
            currentProducts = products
        } else {
            currentProducts = try await fetchProducts()
        }

        guard let product = currentProducts.first else { throw PurchaseError.noProduct }

        let purchaseResult = try await product.purchase()
        switch purchaseResult {
        case .pending:
            print("pending")
        case .success(_):
            print("success")
        case .userCancelled:
            print("cancelled")
        @unknown default:
            print("unknown")
        }
    }

    private static let productIdentifier = "com.flipbookapp.flickbook.kineo-pro"
}
