//  Created by Geoff Pado on 1/28/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct DismissButton: View {
    @Environment(\.dismiss) private var dismiss

    private let text: LocalizedStringKey
    init(text: LocalizedStringKey) {
        self.text = text
    }

    var body: some View {
        Button {
            dismiss()
        } label: {
            Text(text)
                .foregroundStyle(StyleAsset.tutorialIntroDismissButtonTitle.swiftUIColor)
                .font(.appFont(for: .body))
                .frame(maxWidth: .infinity)
        }
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(StyleAsset.sidebarButtonBackground.swiftUIColor)
        }
        .buttonBorderShape(.roundedRectangle(radius: 16))
    }
}
