//  Created by Geoff Pado on 9/16/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct EditingMenu: View {
    @Binding private var isExporting: Bool

    init(isExporting: Binding<Bool>) {
        _isExporting = isExporting
    }

    var body: some View {
        Menu {
            ShareButton(isExporting: $isExporting)
            GalleryButton()
        } label: {
            Image(systemName: "square.and.arrow.up")
        }
        .menuStyle(.button)
        .padding(.bottom, 80)
    }
}
