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
    @State private var isToolPickerVisible: Bool = false

    init() {
        let editingState = EditingState(document: Document(pages: [], backgroundColorHex: nil, backgroundImageData: nil))
        _editingState = State(initialValue: editingState)
    }

    var body: some View {
        GeometryReader { proxy in
            HStack {
                VStack {
                    Button {
                        print("hello gallery")
                    } label: {
                        Image(systemName: "square.grid.2x2")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .glassBackgroundEffect(in: .rect(cornerRadius: 25))
                    }
                    FilmStrip()
                }
                .frame(width: 120, height: proxy.size.height)
                Canvas(editingState: $editingState, isToolPickerVisible: $isToolPickerVisible)
                    .aspectRatio(1, contentMode: .fit).glassBackgroundEffect(in: .rect(cornerRadius: 25))
                    .toolbar {
                        if isToolPickerVisible == false {
                            ToolbarItem(placement: .bottomOrnament) {
                                Button(action: {
                                    isToolPickerVisible = true
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
                                Button(action: {
                                    isToolPickerVisible = true
                                }, label: {
                                    Image(systemName: "square.2.stack.3d.bottom.fill")
                                })
                                Button(action: {
                                    isToolPickerVisible = true
                                }, label: {
                                    Image(systemName: "square.and.arrow.up")
                                })
                            }
                        }
                    }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
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
