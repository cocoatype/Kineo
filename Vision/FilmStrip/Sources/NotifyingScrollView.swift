//  Created by Geoff Pado on 11/17/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI
import SwiftUIIntrospect

struct NotifyingScrollView<Content: View>: View {
    @Binding private var editingState: EditingState

    // bippityBoppity by @nutterfi on 2023-11-13
    // a UIScrollViewDelegate for the UIScrollView backing this view
    @StateObject private var bippityBoppity: Delegate = Delegate()

    private let axes: Axis.Set
    private let showsIndicators: Bool
    private let content: () -> Content

    init(axes: Axis.Set = .vertical, showsIndicators: Bool = true, editingState: Binding<EditingState>,
         @ViewBuilder content: @escaping () -> Content) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.content = content

        _editingState = editingState
    }

    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators, content: content)
            .introspect(.scrollView, on: .visionOS(.v1)) { scrollView in
                bippityBoppity.onScrollingStateChanged = { isScrolling in
                    editingState = editingState.withSkinVisible(!isScrolling)
                }
                scrollView.delegate = bippityBoppity
            }
    }

    private final class Delegate: NSObject, ObservableObject, UIScrollViewDelegate {
        var onScrollingStateChanged: ((Bool) -> Void)?

        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            onScrollingStateChanged?(true)
        }

        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            onScrollingStateChanged?(false)
        }
    }
}
