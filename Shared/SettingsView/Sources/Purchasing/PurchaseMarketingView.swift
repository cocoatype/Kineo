//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import PurchasingPhone
import StylePhone
#elseif os(visionOS)
import PurchasingVision
import StyleVision
#endif

import SwiftUI

@available(iOS 15, *)
struct PurchaseMarketingView: View {
    init(purchaseState: Binding<PurchaseState>) {
        _purchaseState = purchaseState
    }

    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .topTrailing) {
                    PurchaseMarketingTopBar(purchaseState: $purchaseState)
                    PurchaseMarketingCloseButton().padding(12)
                }
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 292, maximum: 292))], spacing: 20) {
                    #if os(iOS)
                    ZoomPurchaseMarketingItem()
                    BackgroundsPurchaseMarketingItem()
                    WatermarkPurchaseMarketingItem()
                    #elseif os(visionOS)
                    SoonPurchaseMarketingItem()
                    #endif
                    SupportPurchaseMarketingItem()
                }.padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
            }
        }
        .fill()
        .frame(idealWidth: 644)
        .background(StyleAsset.purchaseMarketingBackground.swiftUIColor.ignoresSafeArea())
        .navigationBarHidden(true)
    }

    private static let breakWidth = Double(640)

    @Binding private var purchaseState: PurchaseState
}

@available(iOS 15, *)
struct PurchaseMarketingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                PurchaseMarketingView(purchaseState: .constant(.loading))
                    .preferredColorScheme(.dark)
                PurchaseMarketingView(purchaseState: .constant(.loading))
                    .preferredColorScheme(.light)
            }.previewLayout(.fixed(width: 640, height: 1024))
            Group {
                PurchaseMarketingView(purchaseState: .constant(.loading))
                    .preferredColorScheme(.dark)
                PurchaseMarketingView(purchaseState: .constant(.loading))
                    .preferredColorScheme(.light)
            }.previewLayout(.fixed(width: 375, height: 1024))
        }
    }
}
