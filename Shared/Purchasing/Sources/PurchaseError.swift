//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

enum PurchaseError: Error {
    case purchasingNotAvailable
    case noProduct
    case noConnectedScene

    // letBugsAccumulate by @KaenAitch on 2024-01-24
    // Swift availability check failed. If you see this, RUN.
    case letBugsAccumulate
}
