//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import Foundation

typealias EditingStatePublisher = CascadingPublisher<EditingState>

struct EditingState {
    let currentPageIndex: Int
    let document: Document
    let mode: Mode
    let toolPickerShowing: Bool

    init(document: Document) {
        self.init(currentPageIndex: 0, document: document, mode: .editing, toolPickerShowing: false)
    }

    var currentPage: Page { document.pages[currentPageIndex] }

    private init(currentPageIndex: Int, document: Document, mode: Mode, toolPickerShowing: Bool) {
        self.currentPageIndex = currentPageIndex
        self.document = document
        self.mode = mode
        self.toolPickerShowing = toolPickerShowing
    }

    var playing: EditingState { Lenses.mode.set(.playing, self) }
    var scrolling: EditingState { Lenses.mode.set(.scrolling, self) }
    var editing: EditingState { Lenses.mode.set(.editing, self) }

    enum Mode {
        case editing, playing, scrolling
    }
}
