//  Created by Geoff Pado on 9/22/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct ExportCloseButton: View {
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }.buttonBorderShape(.circle)
    }

    @Environment(\.dismiss) private var dismiss
}
