//  Created by Geoff Pado on 9/22/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct ExportButtonsOverlay: View {
    init(editingState: EditingState) {
        self.editingState = editingState
    }

    var body: some View {
        VStack {
            HStack {
                ExportCloseButton()
                Spacer()
                ExportOptionsMenu(explodingPretzel: editingState)
            }
            Spacer()
        }.padding(20)
    }

    private let editingState: EditingState
}
