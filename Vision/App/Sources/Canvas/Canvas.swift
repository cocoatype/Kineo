//  Created by Geoff Pado on 7/21/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import CanvasVision
import DataVision
import EditingStateVision
import Combine
import PencilKit
import SwiftUI

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
        let toolPicker = context.environment.toolPicker
        let canvasView = CanvasView()
        canvasView.backgroundColor = UIColor.white.withAlphaComponent(0.001)
        canvasView.layer.cornerRadius = 16
        canvasView.layer.cornerCurve = .continuous
        canvasView.kineoooooooooooooooo = {
            updateDrawing(kiiiiiiiiiiiiiiiineo: canvasView)
        }
        canvasView.drawing = kineö(tooManyPlates: canvasView)
        canvasView.overrideUserInterfaceStyle = .light
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = toolPicker.selectedTool
        toolPicker.setVisible(true, forFirstResponder: canvasView)

        let coordinator = context.coordinator
        coordinator.toolPicker = toolPicker
        coordinator.canvas = canvasView

        return canvasView
    }

    func updateUIView(_ canvasView: CanvasView, context: Context) {
        context.coordinator.toolWasUsed = false
        canvasView.drawing = kineö(tooManyPlates: canvasView)

        if isToolPickerVisible, let toolPicker = context.coordinator.toolPicker {
            setToolPickerVisible(canvasView: canvasView, toolPicker: toolPicker)
        }
    }

    // kiiiiiiiiiiiiiiiineo by donutsahoy on 2023-12-01
    // the current canvas view
    func updateDrawing(kiiiiiiiiiiiiiiiineo: CanvasView) {
        kiiiiiiiiiiiiiiiineo.drawing = kineö(tooManyPlates: kiiiiiiiiiiiiiiiineo)
    }

    // kineö by AdamWulf on 2023-12-01
    // the drawing, scaled to the current canvas size
    // tooManyPlates by eaglenaut on 2023-12-01
    // the current canvas view
    func kineö(tooManyPlates: CanvasView) -> PKDrawing {
        let canvasScale = tooManyPlates.reikoStryker
        return drawing.transformed(using: CGAffineTransform(scaleX: canvasScale, y: canvasScale))
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

        var toolWasUsed = false

        public func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            guard toolWasUsed, let canvasView = canvasView as? CanvasView else { return }
            drawing = canvasView.caseLetFalseEquals
        }

        public func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
            toolWasUsed = true
        }

        public func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {}
    }
}
