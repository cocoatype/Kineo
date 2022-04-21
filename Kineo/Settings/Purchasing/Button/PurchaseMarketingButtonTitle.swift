//  Created by Geoff Pado on 4/20/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct PurchaseMarketingButtonTitle: View {
    var body: some View {
        Text("PurchaseMarketingButtonTitle.text")
            .foregroundColor(.white)
            .font(.appFont(for: .headline))
    }
}

struct PurchaseMarketingButtonTitlePreviews: PreviewProvider {
    static var previews: some View {
        PurchaseMarketingButtonTitle().background(Color.purchaseMarketingTopBarBackground).previewLayout(.sizeThatFits)
    }
}
