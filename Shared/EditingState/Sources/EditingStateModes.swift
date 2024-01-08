//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

extension EditingState {
    public enum Mode: Equatable {
        case editing, playing(continuously: Bool), layers

        public var isPlaying: Bool {
            switch self {
            case .playing: return true
            case .editing, .layers: return false
            }
        }
    }

    public mutating func playing() -> EditingState {
        mode = .playing(continuously: false)
        return self
    }
    public mutating func playingContinuously() -> EditingState {
        mode = .playing(continuously: true)
        return self
    }
    public mutating func editing() -> EditingState {
        mode = .editing
        return self
    }
    public mutating func layers() -> EditingState {
        mode = .layers
        return self
    }
}
