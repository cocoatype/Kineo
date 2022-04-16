//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 15, *)
struct PurchaseMarketingView: View {
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    ZStack(alignment: .topTrailing) {
                        PurchaseMarketingTopBar()
                        PurchaseMarketingCloseButton().padding(12)
                    }
                    LazyVGrid(columns: columns(forWidth: proxy.size.width), spacing: 20) {
                        ZoomPurchaseMarketingItem()
                        WatermarkPurchaseMarketingItem()
                        SupportPurchaseMarketingItem()
                    }.padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
                }
            }
            .fill()
            .background(Color(.appBackground).ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }

    private static let breakWidth = Double(640)

    private func columns(forWidth width: Double) -> [GridItem] {
        if width < Self.breakWidth {
            return [GridItem(spacing: 20)]
        } else {
            return [GridItem(spacing: 20), GridItem(spacing: 20)]
        }
    }
}

@available(iOS 15, *)
struct PurchaseMarketingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Group {
                PurchaseMarketingView()
                    .preferredColorScheme(.dark)
                PurchaseMarketingView()
                    .preferredColorScheme(.light)
            }.previewLayout(.fixed(width: 640, height: 1024))
            Group {
                PurchaseMarketingView()
                    .preferredColorScheme(.dark)
                PurchaseMarketingView()
                    .preferredColorScheme(.light)
            }.previewLayout(.fixed(width: 375, height: 1024))
        }
    }
}
