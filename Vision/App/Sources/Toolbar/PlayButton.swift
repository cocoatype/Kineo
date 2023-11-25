//  Created by Geoff Pado on 9/4/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct PlayButton: View {
    @Binding private var editingState: EditingState
    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        Button {
            switch editingState.mode {
            case .editing, .scrolling, .layers:
                editingState = editingState.playingContinuously
            case .playing:
                editingState = editingState.editing
            }
        } label: {
            Image(systemName: "play")
        }
    }
}
