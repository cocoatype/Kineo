//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import SwiftUI

struct PurchaseMarketingItem: View {
    private let headerKey: LocalizedStringKey
    private let textKey: LocalizedStringKey
    private let image: Image

    init(header: LocalizedStringKey, text: LocalizedStringKey, image: Image) {
        self.headerKey = header
        self.textKey = text
        self.image = image
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                PurchaseMarketingHeader(headerKey)
                PurchaseMarketingText(textKey)
            }.padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20))
            image.resizable().aspectRatio(290.0/166.0, contentMode: .fit)
        }
        .background(StyleAsset.purchaseMarketingCellBackground.swiftUIColor)
        .cornerRadius(21)
    }
}

struct PurchaseMarketingItemPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            PurchaseMarketingItem(
                header: "PurchaseMarketingItem.support.header",
                text: "PurchaseMarketingItem.support.text",
                image: Asset.support.swiftUIImage
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(StyleAsset.background.swiftUIColor)
        .preferredColorScheme(.dark)
        .previewLayout(.fixed(width: 290, height: 242))
    }
}
