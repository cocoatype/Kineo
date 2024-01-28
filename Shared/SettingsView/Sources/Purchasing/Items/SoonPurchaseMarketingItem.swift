//  Created by Geoff Pado on 1/28/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SoonPurchaseMarketingItem: View {
    var body: some View {
        PurchaseMarketingItem(
            header: Self.header,
            text: Self.text,
            image: Asset.soon.swiftUIImage)
    }

    private static let header = LocalizedStringKey("PurchaseMarketingItem.soon.header")
    private static let text = LocalizedStringKey("PurchaseMarketingItem.soon.text")
}
