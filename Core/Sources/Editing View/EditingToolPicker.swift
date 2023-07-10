//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Canvas
import Combine
import EditingState
import PencilKit

class EditingToolPicker: PKToolPicker {
    init(statePublisher: EditingStatePublisher, drawingView: DrawingView) {
        self.drawingView = drawingView
        super.init()
        drawingView.observe(self)
        _ = drawingView.becomeFirstResponder()

        setVisible(alwaysShowsToolPicker, forFirstResponder: drawingView)

        statePublisher.sink { [weak self] state in
            guard let picker = self, let drawingView = picker.drawingView else { return }
            let toolPickerState = state.toolPickerShowing
            let isVisible = (toolPickerState || picker.alwaysShowsToolPicker)
            picker.setVisible(isVisible, forFirstResponder: drawingView)
            _ = drawingView.becomeFirstResponder()
        }.store(in: &cancellables)
    }

    private var alwaysShowsToolPicker: Bool {
        let sizeClass = drawingView?.traitCollection.horizontalSizeClass
        switch sizeClass {
        case .compact?: return false
        case .regular?: return true
        case .unspecified?, .none: fallthrough
        @unknown default: return false
        }
    }

    deinit {
        drawingView?.stopObserving(self)
    }

    private weak var drawingView: DrawingView?
    private var cancellables = Set<AnyCancellable>()
}
