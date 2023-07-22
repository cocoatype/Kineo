//  Created by Geoff Pado on 7/21/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import CanvasVision
import Combine
import PencilKit
import SwiftUI

struct Canvas: UIViewRepresentable {
    private let canvasView: CanvasView
    private let toolPicker: PKToolPicker
    let isToolPickerVisible: CurrentValueSubject<Bool, Never>

    init() {
        let toolPicker = PKToolPicker()
        let canvasView = CanvasView()
        self.toolPicker = toolPicker
        self.canvasView = canvasView

        canvasView.overrideUserInterfaceStyle = .light
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = .white
        canvasView.tool = PKInkingTool(ink: PKInk(.pen, color: .red), width: 15)
        toolPicker.setVisible(true, forFirstResponder: canvasView)

        let isToolPickerVisible = CurrentValueSubject<Bool, Never>(toolPicker.isVisible && canvasView.isFirstResponder)
        self.isToolPickerVisible = isToolPickerVisible

        canvasView.onFirstResponderChange = {
            isToolPickerVisible.send(toolPicker.isVisible && canvasView.isFirstResponder)
        }
    }

    func setToolPickerVisible() {
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        DispatchQueue.main.async {
            _ = canvasView.becomeFirstResponder()
        }
    }

    func updateToolPickerVisibility() {
        isToolPickerVisible.send(toolPicker.isVisible && canvasView.isFirstResponder)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(canvas: canvasView, toolPicker: toolPicker, isToolPickerVisible: isToolPickerVisible)
    }

    func makeUIView(context: Context) -> some UIView {
        return canvasView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}

    final class Coordinator: NSObject, PKToolPickerObserver {
        private let isToolPickerVisible: CurrentValueSubject<Bool, Never>
        private let canvas: PKCanvasView
        private let toolPicker: PKToolPicker
        init(canvas: PKCanvasView, toolPicker: PKToolPicker, isToolPickerVisible: CurrentValueSubject<Bool, Never>) {
            self.canvas = canvas
            self.isToolPickerVisible = isToolPickerVisible
            self.toolPicker = toolPicker
            super.init()
            toolPicker.addObserver(self)
            canvas.addObserver(self, forKeyPath: #keyPath(PKCanvasView.isFirstResponder), context: nil)
        }

        func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
            updateToolPickerVisibility()
        }

        func updateToolPickerVisibility() {
            isToolPickerVisible.send(toolPicker.isVisible && canvas.isFirstResponder)
        }
    }
}
