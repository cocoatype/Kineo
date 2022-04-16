//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct PurchaseMarketingText: View {
    private let titleKey: LocalizedStringKey
    init(_ titleKey: LocalizedStringKey) {
        self.titleKey = titleKey
    }

    var body: some View {
        Text(titleKey)
//            .lineSpacing(3)
            .font(.appFont(for: .body))
            .foregroundColor(Color(.white))
    }
}

struct PurchaseMarketingTextPreviews: PreviewProvider {
    static var previews: some View {
        PurchaseMarketingText("PurchaseMarketingView.supportDevelopmentText")
            .preferredColorScheme(.dark)
    }
}
