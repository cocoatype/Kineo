//  Created by Geoff Pado on 7/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct LayerButton: View {
    @Binding private var isLayerModeActive: Bool
    init(isLayerModeActive: Binding<Bool>) {
        _isLayerModeActive = isLayerModeActive
    }

    var body: some View {
        Button {
            isLayerModeActive = true
        } label: {
            Image(systemName: "square.2.stack.3d.bottom.fill")
        }
    }
}
