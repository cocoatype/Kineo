//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SupportPurchaseMarketingItem: View {
    var body: some View {
        PurchaseMarketingItem(
            header: Self.header,
            text: Self.text,
            image: Asset.support.swiftUIImage)
    }

    private static let header = LocalizedStringKey("PurchaseMarketingItem.support.header")
    private static let text = LocalizedStringKey("PurchaseMarketingItem.support.text")
}
