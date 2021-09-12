//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

extension EditingState {
    enum Mode {
        case editing, playing, scrolling
    }

    var playing: EditingState { Lenses.mode.set(.playing, self) }
    var scrolling: EditingState { Lenses.mode.set(.scrolling, self) }
    var editing: EditingState { Lenses.mode.set(.editing, self) }
}
