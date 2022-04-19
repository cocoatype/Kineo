//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 15, *)
struct PurchaseMarketingTopBar: View {
    private let purchaser: Purchaser
    init() {
        purchaser = RealPurchaser()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 0) {
                PurchaseMarketingTopBarHeadline()
                PurchaseMarketingTopBarSubheadline()
            }
            HStack {
                PurchaseButton(purchaser: purchaser)
                PurchaseRestoreButton()
            }
        }
        .padding(40)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.purchaseMarketingTopBarBackground)
    }
}

@available(iOS 15, *)
struct PurchaseMarketingTopBarPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            PurchaseMarketingTopBar().preferredColorScheme(.dark)
            PurchaseMarketingTopBar()
        }.previewLayout(.sizeThatFits)
    }
}
