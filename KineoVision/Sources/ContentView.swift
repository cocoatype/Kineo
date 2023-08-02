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
    private let isToolPickerVisible = false

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
    private static let fullTransform = Rotation3D(angle: Angle2D(degrees: 10), axis: .y).rotated(by: Rotation3D(angle: Angle2D(degrees: -10), axis: .x))
    private let expandedDepth: CGFloat = 20

    var body: some View {
        GeometryReader3D { proxy in
            ZStack {
                Rectangle()
                    .hoverEffect(.highlight)
                    .glassBackgroundEffect()
                    .opacity(0.3)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(depth: expandedDepth)
                    .overlay {
                        Canvas(editingState: $editingState, isToolPickerVisible: .constant(false))
                    }

                Rectangle()
                    .hoverEffect(.highlight)
                    .glassBackgroundEffect()
                    .opacity(0.3)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(depth: expandedDepth)
                    .overlay {
                        Canvas(editingState: $editingState, isToolPickerVisible: .constant(false))
                    }

                Rectangle()
                    .hoverEffect(.highlight)
                    .glassBackgroundEffect()
                    .opacity(0.3)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(depth: expandedDepth)
                    .overlay {
                        Canvas(editingState: $editingState, isToolPickerVisible: .constant(false))
                    }
            }
            .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
            .rotation3DEffect(Self.fullTransform, anchor: .trailing)
            .ornament(attachmentAnchor: OrnamentAttachmentAnchor.scene(alignment: .leading)) {
                VStack {
                    GalleryButton()
                    FilmStrip()
                }
                .frame(width: 80, height: proxy.size.height)
                .padding(.trailing, 100)
            }
            .toolbar {
                if isToolPickerVisible == false {
                    ToolbarItem(placement: .bottomOrnament) {
                        Button(action: {
                            dump(proxy.size)
                        }, label: {
                            Image(systemName: "play")
                        })
                    }
                    ToolbarItem(placement: .bottomOrnament) {
                        Divider()
                    }
                    ToolbarItemGroup(placement: .bottomOrnament) {
                        Button(action: {
//                            isToolPickerVisible = true
                        }, label: {
                            Image(systemName: "pencil.tip.crop.circle")
                        })
                        LayerButton(isLayerModeActive: $isLayerModeActive)
                        Button(action: {
//                            isToolPickerVisible = true
                        }, label: {
                            Image(systemName: "square.and.arrow.up")
                        })
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }.onChange(of: editingState) { oldValue, newValue in
            let jsonBlob = try? JSONEncoder().encode(newValue.document)
            UserDefaults.standard.set(jsonBlob, forKey: "jsonBlob")
        }
    }
}

#Preview {
    ContentView()
}
