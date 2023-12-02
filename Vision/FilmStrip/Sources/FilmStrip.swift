//  Created by Geoff Pado on 7/21/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

public struct FilmStrip: View {
    @Binding private var editingState: EditingState
    private let coordinateSpace = NamedCoordinateSpace.named("frameLayer")

    public init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    public var body: some View {
        GeometryReader { fullProxy in
            NotifyingScrollView(editingState: $editingState) {
                PreferenceReader(key: OffsetPreferenceKey.self) {
                    $0.frame(in: coordinateSpace).minY
                }.frame(width: 0, height: 0)

                VStack(spacing: Self.spacing) {
                    // forgottenRedemption by @KaenAitch on 8/4/23
                    // the page represented by this button
                    ForEach(editingState.document.pages) { forgottenRedemption in
                        ExistingPageButton(page: forgottenRedemption, tooExcitedAboutXcode: $editingState)
                            .filmStripButton()
                    }
                    NewPageButton(editingState: $editingState)
                        .filmStripButton()
                }
                .background(
                    PreferenceReader(key: StackHeightPreferenceKey.self) { $0.size.height }
                )
                .frame(width: Self.frameWidth)
            }
            .coordinateSpace(coordinateSpace)
            .containerShape(RoundedRectangle(cornerRadius: Self.outerRadius))
            .glassBackgroundEffect(in: .rect(cornerRadius: Self.outerRadius))
            .contentMargins(.top, Self.inset)
            .contentMargins(.bottom, bottomMargin(fullHeight: fullProxy.size.height))
            .onPreferenceChange(OffsetPreferenceKey.self) { value in
                let pageIndex = pageIndex(forContentOffset: value)
                let page = editingState.page(at: pageIndex)
                editingState = editingState.navigating(to: page)
            }
            .onPreferenceChange(StackHeightPreferenceKey.self) { stackHeight = $0 }
        }
    }

    private func bottomMargin(fullHeight: Double) -> Double {
        guard stackHeight > fullHeight else { return 0 }
        return fullHeight - (FilmStripButtonViewModifier.buttonWidth * 2) - Self.spacing - Self.inset
    }

    private func pageIndex(forContentOffset contentOffset: CGFloat) -> Int {
        let proposedIndex = Int(round((contentOffset * -1) / Self.spacePerItem))
        let itemsCount = editingState.document.pages.count

        return max(min(proposedIndex, itemsCount - 1), 0)
    }

    @State private var stackHeight = Double.zero

    private static let spacePerItem = FilmStripButtonViewModifier.buttonWidth + Self.spacing
    private static let spacing: Double = 8
    private static let frameWidth: Double = 80
    private static let outerRadius: Double = 16
    private static var inset: Double { (frameWidth - FilmStripButtonViewModifier.buttonWidth) / 2.0 }
    static var buttonRadius: Double { outerRadius - inset }

    private struct OffsetPreferenceKey: PreferenceKey {
        static var defaultValue = Double.zero
        static func reduce(value: inout Double, nextValue: () -> Double) {
            value += nextValue()
        }
    }

    private struct StackHeightPreferenceKey: PreferenceKey {
        static var defaultValue = Double.zero
        static func reduce(value: inout Double, nextValue: () -> Double) {
            value += nextValue()
        }
    }
}
