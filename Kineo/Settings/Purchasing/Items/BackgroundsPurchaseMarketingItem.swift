//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct BackgroundsPurchaseMarketingItem: View {
    var body: some View {
        PurchaseMarketingItem(
            header: Self.header,
            text: Self.text,
            imageName: "Backgrounds")
    }

    private static let header = LocalizedStringKey("BackgroundsPurchaseMarketingItem.header")
    private static let text = LocalizedStringKey("BackgroundsPurchaseMarketingItem.text")
}
