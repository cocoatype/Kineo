//  Created by Geoff Pado on 7/21/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import CanvasVision
import DataVision
import EditingStateVision
import Combine
import PencilKit
import SwiftUI

struct DrawingCanvas: View {
    @Binding private var editingState: EditingState
    @State private var drawing: PKDrawing
    @State private var isToolPickerVisible: Bool

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
        _drawing = State(initialValue: editingState.wrappedValue.currentPage.drawing)
        _isToolPickerVisible = State(initialValue: editingState.wrappedValue.toolPickerShowing)
    }

    var body: some View {
        Canvas(drawing: $drawing, isToolPickerVisible: $isToolPickerVisible)
            .onChange(of: drawing) { _, newDrawing in
                editingState = editingState.replacingCurrentPage(with: Page(drawing: newDrawing))
            }.onChange(of: isToolPickerVisible) { _, newVisibility in
                editingState = editingState.settingToolPickerVisible(visible: newVisibility)
            }.onChange(of: editingState) {
                drawing = editingState.currentPage.drawing
                isToolPickerVisible = editingState.toolPickerShowing
            }
    }
}

struct Canvas: UIViewRepresentable {
    @Binding private var drawing: PKDrawing
    @Binding private var isToolPickerVisible: Bool

    init(drawing: PKDrawing) {
        self.init(drawing: .constant(drawing), isToolPickerVisible: .constant(false))
    }

    init(drawing: Binding<PKDrawing>, isToolPickerVisible: Binding<Bool>) {
        _drawing = drawing
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
        return Coordinator(drawing: $drawing, isToolPickerVisible: $isToolPickerVisible)
    }

    func makeUIView(context: Context) -> CanvasView {
        let toolPicker = PKToolPicker()
        let canvasView = CanvasView()

        canvasView.drawing = drawing
        canvasView.overrideUserInterfaceStyle = .light
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(ink: PKInk(.pen, color: .red), width: 15)
        toolPicker.setVisible(true, forFirstResponder: canvasView)

        let coordinator = context.coordinator
        coordinator.toolPicker = toolPicker
        coordinator.canvas = canvasView

        return canvasView
    }

    func updateUIView(_ canvasView: CanvasView, context: Context) {
        canvasView.drawing = drawing
    
        if isToolPickerVisible, let toolPicker = context.coordinator.toolPicker {
            setToolPickerVisible(canvasView: canvasView, toolPicker: toolPicker)
        }
    }

    final class Coordinator: NSObject, PKToolPickerObserver, PKCanvasViewDelegate {
        @Binding var drawing: PKDrawing
        @Binding var isToolPickerVisible: Bool

        var canvas: CanvasView? {
            didSet {
                canvas?.delegate = self
                canvas?.onFirstResponderChange = { [weak self] in
                    guard let self, let toolPicker, let canvas else { return }
                    isToolPickerVisible = (toolPicker.isVisible && canvas.isFirstResponder)
                }
            }
        }

        var toolPicker: PKToolPicker? {
            didSet {
                oldValue?.removeObserver(self)
                toolPicker?.addObserver(self)
            }
        }

        init(drawing: Binding<PKDrawing>, isToolPickerVisible: Binding<Bool>) {
            _drawing = drawing
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
            drawing = canvasView.drawing
        }

        public func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {}

        public func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {}
    }
}
