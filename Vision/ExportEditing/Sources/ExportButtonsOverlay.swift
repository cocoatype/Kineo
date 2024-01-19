//  Created by Geoff Pado on 9/22/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct ExportButtonsOverlay: View {
    private let editingState: EditingState
    @Binding private var playbackStyle: PlaybackStyle
    init(editingState: EditingState, playbackStyle: Binding<PlaybackStyle>) {
        self.editingState = editingState
        _playbackStyle = playbackStyle
    }

    var body: some View {
        VStack {
            HStack {
                ExportCloseButton()
                Spacer()
                ExportOptionsMenu(explodingPretzel: editingState, playbackStyle: $playbackStyle)
            }
            Spacer()
        }.padding(20)
    }
}
