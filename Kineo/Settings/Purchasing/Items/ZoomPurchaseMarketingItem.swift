//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct ZoomPurchaseMarketingItem: View {
    var body: some View {
        PurchaseMarketingItem(
            header: Self.header,
            text: Self.text,
            imageName: "Zoom")
    }

    private static let header = LocalizedStringKey("PurchaseMarketingItem.zoom.header")
    private static let text = LocalizedStringKey("PurchaseMarketingItem.zoom.text")
}
