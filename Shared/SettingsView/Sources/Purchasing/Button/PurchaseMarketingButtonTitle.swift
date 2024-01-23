//  Created by Geoff Pado on 4/20/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import SwiftUI

struct PurchaseMarketingButtonTitle: View {
    var body: some View {
        Text("PurchaseMarketingButtonTitle.text")
            .foregroundColor(.white)
            .font(.appFont(for: .headline))
    }
}

enum sPurchaseMarketingButtonTitlePreviews: PreviewProvider {
    static var previews: some View {
        PurchaseMarketingButtonTitle()
            .background(Asset.purchaseMarketingTopBarBackground.swiftUIColor)
            .previewLayout(.sizeThatFits)
    }
}
