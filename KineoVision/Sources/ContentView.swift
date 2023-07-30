//
//  ContentView.swift
//  KineoVision
//
//  Created by Geoff Pado on 7/10/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.
//

import Combine
import DataVision
import EditingStateVision
import PencilKit
import SwiftUI

struct ContentView: View {
    @State private var editingState: EditingState
    @State private var isLayerModeActive = false
    @State private var isToolPickerVisible = false

    init() {
        let document: Document
        if let json = UserDefaults.standard.data(forKey: "jsonBlob") {
            print("got json")
            do {
                document = try JSONDecoder().decode(Document.self, from: json)
                print("decoded json")
            } catch {
                print("json error: \(String(describing: error))")
                document = Document(pages: [Page()], backgroundColorHex: nil, backgroundImageData: nil)
            }
        } else {
            print("no json")
            document = Document(pages: [Page()], backgroundColorHex: nil, backgroundImageData: nil)
        }
        _editingState = State(initialValue: EditingState(document: document))
    }

    @State private var isAnimating = false
    private static let fullTransform = Rotation3D(angle: Angle2D(degrees: 30), axis: .y).rotated(by: Rotation3D(angle: Angle2D(degrees: 0), axis: .x))

    var body: some View {
        GeometryReader3D { proxy in
            HStack {
                VStack {
                    GalleryButton()
                    FilmStrip()
                }.frame(width: 120, height: proxy.size.height)
                    .opacity(self.isAnimating ? 0 : 1)
                    .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
                Canvas(editingState: $editingState, isToolPickerVisible: $isToolPickerVisible)
                    .aspectRatio(1, contentMode: .fit)
                    .glassBackgroundEffect(in: .rect(cornerRadius: 25))
                    .rotation3DEffect((self.isAnimating ? Self.fullTransform : .identity), anchor: .leading)
//                    .transform3DEffect(
//                        self.isAnimating ? Self.fullTransform : AffineTransform3D.identity
//                    )
                    .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
                    .onAppear { isAnimating = true }
                    .toolbar {
                        if isToolPickerVisible == false {
                            ToolbarItem(placement: .bottomOrnament) {
                                Button(action: {
                                    dump(proxy.size)
//                                    isToolPickerVisible = true
                                }, label: {
                                    Image(systemName: "play")
                                })
                            }
                            ToolbarItem(placement: .bottomOrnament) {
                                Divider()
                            }
                            ToolbarItemGroup(placement: .bottomOrnament) {
                                Button(action: {
                                    isToolPickerVisible = true
                                }, label: {
                                    Image(systemName: "pencil.tip.crop.circle")
                                })
                                LayerButton(isLayerModeActive: $isLayerModeActive)
                                Button(action: {
                                    isToolPickerVisible = true
                                }, label: {
                                    Image(systemName: "square.and.arrow.up")
                                })
                            }
                        }
                    }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .frame(depth: proxy.size.depth, alignment: .center)
        }.onChange(of: editingState) { oldValue, newValue in
            print("yo")
            let jsonBlob = try? JSONEncoder().encode(newValue.document)
            UserDefaults.standard.set(jsonBlob, forKey: "jsonBlob")
        }.transform3DEffect(AffineTransform3D(translation: Vector3D.forward))
    }
}

struct FilmStrip: View {
    private static let frameWidth: Double = 120
    private static let buttonWidth: Double = 110
    private static let outerRadius: Double = 25
    private static var inset: Double { frameWidth - buttonWidth }
    private static var innerRadius: Double { outerRadius - inset }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<30) { _ in
                    Color.white
                        .frame(width: Self.buttonWidth, height: Self.buttonWidth)
                        .clipShape(.rect(cornerRadius: Self.innerRadius))
                }
            }.frame(width: Self.frameWidth)
        }
        .glassBackgroundEffect(in: .rect(cornerRadius: Self.outerRadius))
        .contentMargins(.top, Self.inset)
    }
}

#Preview {
    ContentView()
}
