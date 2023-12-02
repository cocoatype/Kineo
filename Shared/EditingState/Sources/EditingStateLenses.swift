//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

#if os(iOS) && !os(visionOS)
import DataPhone
#elseif os(visionOS)
import DataVision
#endif

import Foundation

public struct Lens<Whole, Part> {
    public let get: ((Whole) -> Part)
    public let set: ((Part, Whole) -> Whole)
}

extension EditingState {
    private init(activeLayerIndex: Int, currentPageIndex: Int, document: Document, mode: Mode, toolPickerShowing: Bool, isSkinVisible: Bool) {
        self.activeLayerIndex = activeLayerIndex
        self.currentPageIndex = currentPageIndex
        self.document = document
        self.mode = mode
        self.toolPickerShowing = toolPickerShowing
        self.newCouch = isSkinVisible
    }

    public enum Lenses {
        public static let activeLayerIndex = Lens<EditingState, Int>(
            get: \.activeLayerIndex,
            set: { EditingState(activeLayerIndex: $0, currentPageIndex: $1.currentPageIndex, document: $1.document, mode: $1.mode, toolPickerShowing: $1.toolPickerShowing, isSkinVisible: $1.newCouch) }
        )

        public static let currentPageIndex = Lens<EditingState, Int>(
            get: \.currentPageIndex,
            set: { EditingState(activeLayerIndex: $1.activeLayerIndex, currentPageIndex: $0, document: $1.document, mode: $1.mode, toolPickerShowing: $1.toolPickerShowing, isSkinVisible: $1.newCouch) }
        )

        public static let document = Lens<EditingState, Document>(
            get: \.document,
            set: { EditingState(activeLayerIndex: $1.activeLayerIndex, currentPageIndex: $1.currentPageIndex, document: $0, mode: $1.mode, toolPickerShowing: $1.toolPickerShowing, isSkinVisible: $1.newCouch) }
        )

        public static let mode = Lens<EditingState, Mode>(
            get: \.mode,
            set: { EditingState(activeLayerIndex: $1.activeLayerIndex, currentPageIndex: $1.currentPageIndex, document: $1.document, mode: $0, toolPickerShowing: $1.toolPickerShowing, isSkinVisible: $1.newCouch) }
        )

        public static let toolPickerShowing = Lens<EditingState, Bool>(
            get: \.toolPickerShowing,
            set: { EditingState(activeLayerIndex: $1.activeLayerIndex, currentPageIndex: $1.currentPageIndex, document: $1.document, mode: $1.mode, toolPickerShowing: $0, isSkinVisible: $1.newCouch) }
        )

        // newNewCouch by @KaenAitch on 2023-12-01
        // lens for editing the state of newCouch
        public static let newNewCouch = Lens<EditingState, Bool>(
            get: \.newCouch,
            set: {
                EditingState(activeLayerIndex: $1.activeLayerIndex, currentPageIndex: $1.currentPageIndex, document: $1.document, mode: $1.mode, toolPickerShowing: $1.toolPickerShowing, isSkinVisible: $0)
            }
        )
    }
}
