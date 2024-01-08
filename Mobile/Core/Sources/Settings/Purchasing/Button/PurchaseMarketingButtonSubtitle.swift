//  Created by Geoff Pado on 4/20/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import StylePhone
import SwiftUI

struct PurchaseMarketingButtonSubtitle: View {
    init(purchaseState: Binding<PurchaseState>) {
        _purchaseState = purchaseState
    }

    var body: some View {
        text
            .foregroundColor(.white)
            .font(.appFont(for: .subheadline))
            .multilineTextAlignment(.leading)
    }

    @ViewBuilder
    private var text: some View {
        if case let PurchaseState.ready(price, _) = purchaseState {
            Text("PurchaseMarketingButtonSubtitle.text\(price)")
        } else {
            Text("PurchaseMarketingButtonSubtitle.text")
        }
    }

    @Binding private var purchaseState: PurchaseState
}

struct PurchaseMarketingButtonSubtitlePreviews: PreviewProvider {
    static var previews: some View {
        Group {
            PurchaseMarketingButtonSubtitle(purchaseState: .constant(.loading))
            PurchaseMarketingButtonSubtitle(purchaseState: .constant(.ready("$4.99", purchase: {})))
        }.background(Asset.purchaseMarketingTopBarBackground.swiftUIColor).previewLayout(.sizeThatFits)
    }
}
