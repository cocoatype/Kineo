//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct CanvasToolbarContent: ToolbarContent {
    @Binding private var isToolPickerVisible: Bool
    @Binding private var isLayerModeActive: Bool
    init(isToolPickerVisible: Binding<Bool>, isLayerModeActive: Binding<Bool>) {
        _isToolPickerVisible = isToolPickerVisible
        _isLayerModeActive = isLayerModeActive
    }

    var body: some ToolbarContent {
        if isToolPickerVisible == false {
            ToolbarItem(placement: .bottomOrnament) {
                Button(action: {
                    dump("toolbar")
                }, label: {
                    Image(systemName: "play")
                })
            }
            ToolbarItem(placement: .bottomOrnament) {
                Divider()
            }
            ToolbarItemGroup(placement: .bottomOrnament) {
                ToolPickerButton(isToolPickerVisible: $isToolPickerVisible)
                LayerButton(isLayerModeActive: $isLayerModeActive)
                ShareButton()
            }
        }
    }
}
