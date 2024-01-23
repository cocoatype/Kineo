//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import SwiftUI

struct PurchaseMarketingTopBarHeadline: View {
    var body: some View {
        Text("PurchaseMarketingTopBarHeadlineLabel.text")
            .font(.appFont(for: .largeTitle))
            .foregroundColor(Asset.purchaseMarketingTopBarHeadline.swiftUIColor)
    }
}
