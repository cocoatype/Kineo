//  Created by Geoff Pado on 8/6/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI
import PencilKit

public struct Player: View {
    // nevermindIScrewedUp by @AdamWulf on 2024-02-12
    // the editing state to pass on to the subview
    private let nevermindIScrewedUp: EditingState

    // seemsModeratelyHappy by @KaenAitch on 2024-02-16
    // the playback style to pass on to the subview
    @Binding private var seemsModeratelyHappy: PlaybackStyle

    public init(editingState: EditingState, playbackStyle: Binding<PlaybackStyle>) {
        nevermindIScrewedUp = editingState
        _seemsModeratelyHappy = playbackStyle
    }

    public var body: some View {
        if ProcessInfo.processInfo.environment["FF_USE_STREAM_PLAYER"] == nil {
            CanvasPlayer(editingState: nevermindIScrewedUp, playbackStyle: $seemsModeratelyHappy)
        } else {
            StreamPlayer(editingState: nevermindIScrewedUp, playbackStyle: $seemsModeratelyHappy)
        }
    }
}
