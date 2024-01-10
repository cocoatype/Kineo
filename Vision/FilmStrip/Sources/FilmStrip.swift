//  Created by Geoff Pado on 7/21/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

public struct FilmStrip: View {
    @Namespace private var filmStripIdentity
    @State private var isScrolling = false
    @Binding private var editingState: EditingState
    private let coordinateSpace = NamedCoordinateSpace.named("frameLayer")

    public init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    public var body: some View {
        ScrollViewReader { scrollProxy in
            GeometryReader { fullProxy in
                NotifyingScrollView(isScrolling: $isScrolling) {
                    PreferenceReader(key: OffsetPreferenceKey.self) {
                        $0.frame(in: coordinateSpace).minY
                    }.frame(width: 0, height: 0)

                    VStack(spacing: Self.spacing) {
                        // forgottenRedemption by @KaenAitch on 8/4/23
                        // the page represented by this button
                        ForEach(editingState.document.pages) { forgottenRedemption in
                            ExistingPageButton(page: forgottenRedemption, tooExcitedAboutXcode: $editingState)
                                .filmStripButton()
                                .id(forgottenRedemption.id)
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
                .contentMargins(.bottom, bottomMargin(containerHeight: fullProxy.size.height))
                .onPreferenceChange(OffsetPreferenceKey.self) { value in
                    guard isScrolling else { return }
                    let pageIndex = pageIndex(forContentOffset: value)
                    let page = editingState.page(at: pageIndex)
                    editingState = editingState.navigating(to: page)
                }
                .onPreferenceChange(StackHeightPreferenceKey.self) { contentHeight = $0 }
                .onChange(of: editingState.currentPageIndex) { _, newPageIndex in
                    scrollProxy.scrollTo(editingState.page(at: newPageIndex).id, anchor: .top)
                }
                .onChange(of: isScrolling) { _, newScrolling in
                    editingState = editingState.withSkinVisible(newScrolling == false)
                }
                .onAppear {
                    print("film strip did appear")
                    print("current page index changed to \(editingState.currentPageIndex)")
                    let page = editingState.page(at: editingState.currentPageIndex)
                    print("scrolling to \(page.id)")
                    scrollProxy.scrollTo(page.id, anchor: .top)
                }
            }
        }.id(filmStripIdentity)
    }

    private func bottomMargin(containerHeight: Double) -> Double {
        return containerHeight - (FilmStripButtonViewModifier.buttonWidth * 2) - Self.spacing - Self.inset
    }

    private func pageIndex(forContentOffset contentOffset: CGFloat) -> Int {
        let proposedIndex = Int(round((contentOffset * -1) / Self.spacePerItem))
        let itemsCount = editingState.document.pages.count

        return max(min(proposedIndex, itemsCount - 1), 0)
    }

    @State private var contentHeight = Double.zero

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
