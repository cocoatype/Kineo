//  Created by Geoff Pado on 3/21/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import StoreKit

final class TransactionObserver {
    var updates: Task<Void, Never>? = nil

    init() {
        updates = Task {
            if #available(iOS 15, *) {
                await listenForTransactions()
            }
        }
    }

    deinit {
        // Cancel the update handling task when you deinitialize the class.
        updates?.cancel()
    }

    @available(iOS 15, *)
    private func listenForTransactions() async {
        for await verificationResult in Transaction.updates {
            guard case .verified(let transaction) = verificationResult else {
                // Ignore unverified transactions.
                continue
            }

            if let revocationDate = transaction.revocationDate {
                print(revocationDate)
                print(transaction.revocationReason ?? "(null)")
                // Remove access to the product identified by transaction.productID.
                // Transaction.revocationReason provides details about
                // the revoked transaction.
            } else if let expirationDate = transaction.expirationDate,
                expirationDate < Date() {
                // Do nothing, this subscription is expired.
                print("expired")
                continue
            } else if transaction.isUpgraded {
                // Do nothing, there is an active transaction
                // for a higher level of service.
                print("upgraded")
                continue
            } else {
                print("access granted")
                // Provide access to the product identified by
                // transaction.productID.
            }
        }
    }
}
