//  Created by Geoff Pado on 7/21/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import CanvasVision
import DataVision
import EditingStateVision
import Combine
import PencilKit
import SwiftUI

struct Canvas: UIViewRepresentable {
    @Binding private var editingState: EditingState
    @Binding private var isToolPickerVisible: Bool

    init(editingState: Binding<EditingState>, isToolPickerVisible: Binding<Bool>) {
        _editingState = editingState
        _isToolPickerVisible = isToolPickerVisible
    }

    func setToolPickerVisible(canvasView: CanvasView, toolPicker: PKToolPicker) {
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        DispatchQueue.main.async {
            _ = canvasView.becomeFirstResponder()
        }
    }

    func updateToolPickerVisibility(canvasView: CanvasView, toolPicker: PKToolPicker) {
        self.isToolPickerVisible = (toolPicker.isVisible && canvasView.isFirstResponder)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(editingState: $editingState, isToolPickerVisible: $isToolPickerVisible)
    }

    func makeUIView(context: Context) -> CanvasView {
        let toolPicker = PKToolPicker()
        let canvasView = CanvasView()

        canvasView.drawing = editingState.currentPage.drawing
        canvasView.overrideUserInterfaceStyle = .light
        canvasView.drawingPolicy = .anyInput
//        canvasView.backgroundColor = .white
        canvasView.tool = PKInkingTool(ink: PKInk(.pen, color: .red), width: 15)
        toolPicker.setVisible(true, forFirstResponder: canvasView)

        let coordinator = context.coordinator
        coordinator.toolPicker = toolPicker
        coordinator.canvas = canvasView

        return canvasView
    }

    func updateUIView(_ canvasView: CanvasView, context: Context) {
        canvasView.drawing = editingState.currentPage.drawing
    
        if isToolPickerVisible, let toolPicker = context.coordinator.toolPicker {
            setToolPickerVisible(canvasView: canvasView, toolPicker: toolPicker)
        }
    }

    final class Coordinator: NSObject, PKToolPickerObserver, PKCanvasViewDelegate {
        @Binding var editingState: EditingState
        @Binding var isToolPickerVisible: Bool
        var canvas: CanvasView? {
            didSet {
                oldValue?.removeObserver(self, forKeyPath: #keyPath(PKCanvasView.isFirstResponder))
                canvas?.delegate = self
                canvas?.onFirstResponderChange = { [weak self] in
                    guard let self, let toolPicker, let canvas else { return }
                    isToolPickerVisible = (toolPicker.isVisible && canvas.isFirstResponder)
                }
                canvas?.addObserver(self, forKeyPath: #keyPath(PKCanvasView.isFirstResponder), context: nil)
            }
        }

        var toolPicker: PKToolPicker? {
            didSet {
                oldValue?.removeObserver(self)
                toolPicker?.addObserver(self)
            }
        }

        init(editingState: Binding<EditingState>, isToolPickerVisible: Binding<Bool>) {
            _editingState = editingState
            _isToolPickerVisible = isToolPickerVisible
        }

        // MARK: PKToolPickerObserver

        func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
            updateToolPickerVisibility()
        }

        func updateToolPickerVisibility() {
            guard let toolPicker, let canvas else { return }
            isToolPickerVisible = (toolPicker.isVisible && canvas.isFirstResponder)
        }

        // MARK: PKCanvasViewDelegate

        public func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            editingState = editingState.replacingCurrentPage(with: Page(drawing: canvasView.drawing))
        }

        public func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {}

        public func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {}
    }
}
