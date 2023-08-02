//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct ToolPickerButton: View {
    @Binding private var isToolPickerVisible: Bool

    init(isToolPickerVisible: Binding<Bool>) {
        _isToolPickerVisible = isToolPickerVisible
    }

    var body: some View {
        Button(action: {
            isToolPickerVisible = true
        }, label: {
            Image(systemName: "pencil.tip.crop.circle")
        })
    }
}
