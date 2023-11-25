//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct KeyboardPurchaseMarketingItem: View {
    var body: some View {
        PurchaseMarketingItem(
            header: Self.header,
            text: Self.text,
            imageName: "Keyboard")
    }

    private static let header = LocalizedStringKey("KeyboardPurchaseMarketingItem.header")
    private static let text = LocalizedStringKey("KeyboardPurchaseMarketingItem.text")
}
