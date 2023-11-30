//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

#if os(iOS) && !os(visionOS)
import DataPhone
import DocumentNavigationPhone
#elseif os(visionOS)
import DataVision
import DocumentNavigationVision
#endif
import UIKit

extension EditingState {
    private func boundedIndex(for proposedIndex: Int) -> Int {
        guard proposedIndex >= 0 else { return 0 }
        guard proposedIndex < pageCount else { return pageCount - 1 }
        return proposedIndex
    }

    public func navigating(sender: Any, event: PageNavigationEvent) -> EditingState {
        let newIndex: Int
        if let keyCommand = (sender as? UIKeyCommand) {
            switch keyCommand.input {
            case UIKeyCommand.inputLeftArrow?:
                 newIndex = boundedIndex(for: currentPageIndex - 1)
            case UIKeyCommand.inputRightArrow?:
                newIndex = boundedIndex(for: currentPageIndex + 1)
            default: newIndex = currentPageIndex
            }
        } else {
            let eventIndex: Int
            switch event.style {
            case .direct(let pageIndex): eventIndex = pageIndex
            case .increment: eventIndex = currentPageIndex + 1
            case .decrement: eventIndex = currentPageIndex - 1
            }
            newIndex = boundedIndex(for: eventIndex)
        }

        guard newIndex != currentPageIndex else { return self }
        return EditingState.Lenses.currentPageIndex.set(newIndex, self)
    }

    public func navigating(to page: Page) -> EditingState {
        guard page != currentPage, let pageIndex = document.pages.firstIndex(of: page) else { return self }
        return EditingState.Lenses.currentPageIndex.set(pageIndex, self)
    }
}
