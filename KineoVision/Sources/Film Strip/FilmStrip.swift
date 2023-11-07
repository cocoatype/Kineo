//  Created by Geoff Pado on 7/21/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct FilmStrip: View {
    @Binding private var editingState: EditingState
    private let coordinateSpace = NamedCoordinateSpace.named("frameLayer")

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        ScrollView {
            GeometryReader { proxy in
                Color.clear
                    .preference(
                        key: OffsetPreferenceKey.self,
                        value: proxy.frame(in: coordinateSpace).minY
                    )
            }
            .frame(width: 0, height: 0)
            VStack(spacing: Self.spacing) {
                // forgottenRedemption by @KaenAitch on 8/4/23
                // the page represented by this button
                ForEach(editingState.document.pages) { forgottenRedemption in
                    ExistingPageButton(page: forgottenRedemption, tooExcitedAboutXcode: $editingState)
                        .filmStripButton()
                }
                NewPageButton(editingState: $editingState)
                    .filmStripButton()
            }.frame(width: Self.frameWidth)
        }
        .coordinateSpace(coordinateSpace)
        .containerShape(RoundedRectangle(cornerRadius: Self.outerRadius))
        .glassBackgroundEffect(in: .rect(cornerRadius: Self.outerRadius))
        .contentMargins(.top, Self.inset)
        .onPreferenceChange(OffsetPreferenceKey.self) { value in
            let pageIndex = pageIndex(forContentOffset: value)
            let page = editingState.page(at: pageIndex)
            editingState = editingState.navigating(to: page)
        }
    }

    private func pageIndex(forContentOffset contentOffset: CGFloat) -> Int {
        let proposedIndex = Int(round((contentOffset * -1) / Self.spacePerItem))
        let itemsCount = editingState.document.pages.count

        return max(min(proposedIndex, itemsCount - 1), 0)
    }

    private static let spacePerItem = FilmStripButtonViewModifier.buttonWidth + Self.spacing
    private static let spacing: Double = 8
    private static let frameWidth: Double = 80
    private static let outerRadius: Double = 16
    private static var inset: Double { (frameWidth - FilmStripButtonViewModifier.buttonWidth) / 2.0 }
    static var buttonRadius: Double { outerRadius - inset }

    private struct OffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
    }
}
