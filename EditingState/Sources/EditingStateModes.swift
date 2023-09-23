//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

extension EditingState {
    public enum Mode: Equatable {
        case editing, playing(continuously: Bool), scrolling

        public var isPlaying: Bool {
            switch self {
            case .editing, .scrolling: return false
            case .playing: return true
            }
        }
    }

    public var playing: EditingState { Lenses.mode.set(.playing(continuously: false), self) }
    public var playingContinuously: EditingState { Lenses.mode.set(.playing(continuously: true), self) }
    public var scrolling: EditingState { Lenses.mode.set(.scrolling, self) }
    public var editing: EditingState { Lenses.mode.set(.editing, self) }
}
