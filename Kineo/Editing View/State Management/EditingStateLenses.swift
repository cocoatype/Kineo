//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import Foundation

struct Lens<Whole, Part> {
    let get: ((Whole) -> Part)
    let set: ((Part, Whole) -> Whole)
}

extension EditingState {
    private init(currentPageIndex: Int, document: Document, mode: Mode, toolPickerShowing: Bool) {
        self.currentPageIndex = currentPageIndex
        self.document = document
        self.mode = mode
        self.toolPickerShowing = toolPickerShowing
    }

    enum Lenses {
        static let document = Lens<EditingState, Document>(
            get: \.document,
            set: { EditingState(currentPageIndex: $1.currentPageIndex, document: $0, mode: $1.mode, toolPickerShowing: $1.toolPickerShowing) }
        )

        static let currentPageIndex = Lens<EditingState, Int>(
            get: \.currentPageIndex,
            set: { EditingState(currentPageIndex: $0, document: $1.document, mode: $1.mode, toolPickerShowing: $1.toolPickerShowing) }
        )

        static let mode = Lens<EditingState, Mode>(
            get: \.mode,
            set: { EditingState(currentPageIndex: $1.currentPageIndex, document: $1.document, mode: $0, toolPickerShowing: $1.toolPickerShowing) }
        )

        static let toolPickerShowing = Lens<EditingState, Bool>(
            get: \.toolPickerShowing,
            set: { EditingState(currentPageIndex: $1.currentPageIndex, document: $1.document, mode: $1.mode, toolPickerShowing: $0) }
        )
    }
}
