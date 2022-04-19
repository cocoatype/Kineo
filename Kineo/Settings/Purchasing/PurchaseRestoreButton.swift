//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 15, *)
struct PurchaseRestoreButton: View {
    var body: some View {
        Button("Restore") {}.purchaseMarketingStyle()
    }
}

@available(iOS 15, *)
struct PurchaseRestoreButtonPreviews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            PurchaseRestoreButton()
        }.fill().background(Color.purchaseMarketingTopBarBackground)
    }
}
