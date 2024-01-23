//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import SwiftUI

struct PurchaseMarketingTopBarSubheadline: View {
    var body: some View {
        Text("PurchaseMarketingTopBarSubheadlineLabel.text")
            .font(.appFont(for: .body))
            .foregroundColor(Asset.purchaseMarketingTopBarSubheadline.swiftUIColor)
    }
}
