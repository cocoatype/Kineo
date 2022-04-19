//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct WatermarkPurchaseMarketingItem: View {
    var body: some View {
        PurchaseMarketingItem(
            header: Self.header,
            text: Self.text,
            imageName: "RemoveWatermark")
    }

    private static let header = LocalizedStringKey("PurchaseMarketingItem.watermark.header")
    private static let text = LocalizedStringKey("PurchaseMarketingItem.watermark.text")
}
