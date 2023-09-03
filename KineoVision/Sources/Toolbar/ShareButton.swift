//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct ShareButton: View {
    @Binding private var isExporting: Bool

    init(isExporting: Binding<Bool>) {
        _isExporting = isExporting
    }

    var body: some View {
        Button {
            isExporting = true
        } label: {
            Image(systemName: "square.and.arrow.up")
        }
    }
}
