//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 15, *)
struct PurchaseMarketingCloseButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        #if targetEnvironment(macCatalyst)
        EmptyView()
        #else
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark")
                .font(.appFont(for: .headline))
                .foregroundColor(.white)
        }.purchaseMarketingStyle()
        #endif
    }
}
