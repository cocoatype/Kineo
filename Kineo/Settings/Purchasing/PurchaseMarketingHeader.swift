//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct PurchaseMarketingHeader: View {
    private let titleKey: LocalizedStringKey
    init(_ titleKey: LocalizedStringKey) {
        self.titleKey = titleKey
    }

    var body: some View {
        Text(titleKey)
            .font(.appFont(for: .headline))
            .foregroundColor(.purchaseMarketingCellText)
            .lineLimit(1)
    }
}
