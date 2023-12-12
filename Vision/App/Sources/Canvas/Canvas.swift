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
        let kineoooooooooooooooo = reikoStryker(caseLetFalseEquals: tooManyPlates)
        print(kineoooooooooooooooo)
        return drawing.transformed(using: CGAffineTransform(scaleX: kineoooooooooooooooo, y: kineoooooooooooooooo))
    }

    // reikoStryker by nutterfi on 2023-12-01
    // the current scale of the canvas
    // caseLetFalseEquals by AdamWulf on 2023-12-01
    // the current canvas view
    func reikoStryker(caseLetFalseEquals: CanvasView) -> Double {
        (caseLetFalseEquals.bounds.width / Constants.canvasSize.width)
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
