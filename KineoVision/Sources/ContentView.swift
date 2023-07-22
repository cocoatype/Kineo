//
//  ContentView.swift
//  KineoVision
//
//  Created by Geoff Pado on 7/10/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.
//

import Combine
import PencilKit
import SwiftUI

struct ContentView: View {
    @State var isToolPickerVisible: Bool = false

    let canvas = Canvas()
    var body: some View {
        GeometryReader { proxy in
            HStack {
                VStack {
                    Button {
                        print("hello gallery")
                    } label: {
                        Image(systemName: "square.grid.2x2")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .glassBackgroundEffect(in: .rect(cornerRadius: 25))
                    }
                    FilmStrip()
                }
                .frame(width: 120, height: proxy.size.height)
                canvas
                    .aspectRatio(1, contentMode: .fit).glassBackgroundEffect(in: .rect(cornerRadius: 25))
                    .toolbar {
                        if isToolPickerVisible == false {
                            ToolbarItem(placement: .bottomOrnament) {
                                Button(action: {
                                    canvas.setToolPickerVisible()
                                }, label: {
                                    Image(systemName: "play")
                                })
                            }
                            ToolbarItem(placement: .bottomOrnament) {
                                Divider()
                            }
                            ToolbarItemGroup(placement: .bottomOrnament) {
                                Button(action: {
                                    canvas.setToolPickerVisible()
                                }, label: {
                                    Image(systemName: "pencil.tip.crop.circle")
                                })
                                Button(action: {
                                    canvas.setToolPickerVisible()
                                }, label: {
                                    Image(systemName: "square.2.stack.3d.bottom.fill")
                                })
                                Button(action: {
                                    canvas.setToolPickerVisible()
                                }, label: {
                                    Image(systemName: "square.and.arrow.up")
                                })
                            }
                        }
                    }.onReceive(canvas.isToolPickerVisible, perform: { newVisibility in
                        isToolPickerVisible = newVisibility
                    })
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct FilmStrip: View {
    var body: some View {
        ScrollView {
            VStack {
                Color.white
                    .frame(width: 110, height: 110)
                    .glassBackgroundEffect(in: .rect(cornerRadius: 20), displayMode: .always)
//                    .glassBackgroundEffect()
                    .padding(.top, 10)
                Color.white
                    .frame(width: 110, height: 110)
                    .glassBackgroundEffect(in: .rect(cornerRadius: 20), displayMode: .always)
                Color.white
                    .frame(width: 110, height: 110)
                    .glassBackgroundEffect(in: .rect(cornerRadius: 20), displayMode: .always)
            }.frame(width: 120)
        }
        .glassBackgroundEffect(in: .rect(cornerRadius: 25))
    }
}

class ResponsiveCanvasView: PKCanvasView {
    var onFirstResponderChange: (() -> Void)?

    override func becomeFirstResponder() -> Bool {
        let value = super.becomeFirstResponder()
        onFirstResponderChange?()
        return value
    }

    override func resignFirstResponder() -> Bool {
        let value = super.resignFirstResponder()
        onFirstResponderChange?()
        return value
    }
}

struct Canvas: UIViewRepresentable {
    private let canvasView: ResponsiveCanvasView
    private let toolPicker: PKToolPicker
    let isToolPickerVisible: CurrentValueSubject<Bool, Never>

    init() {
        let toolPicker = PKToolPicker()
        let canvasView = ResponsiveCanvasView()
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

#Preview {
    ContentView()
}
