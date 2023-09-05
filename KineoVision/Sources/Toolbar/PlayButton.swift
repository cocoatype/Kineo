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
        Button(action: {
            editingState = editingState.playingContinuously
        }, label: {
            Image(systemName: "play")
        })
    }
}
