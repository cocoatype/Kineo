//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import SwiftUI

struct PurchaseMarketingItem: View {
    init(header: LocalizedStringKey, text: LocalizedStringKey, imageName: String) {
        self.headerKey = header
        self.textKey = text
        self.imageName = imageName
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                PurchaseMarketingHeader(headerKey)
                PurchaseMarketingText(textKey)
            }.padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20))
            Image(imageName).resizable().aspectRatio(290.0/166.0, contentMode: .fit)
        }
        .background(Asset.purchaseMarketingCellBackground.swiftUIColor)
        .cornerRadius(21)
    }

    private let headerKey: LocalizedStringKey
    private let textKey: LocalizedStringKey
    private let imageName: String
}

struct PurchaseMarketingItemPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            PurchaseMarketingItem(header: "PurchaseMarketingItem.support.header", text: "PurchaseMarketingItem.support.text", imageName: "Support")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Asset.background.swiftUIColor)
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 290, height: 242))
    }
}
