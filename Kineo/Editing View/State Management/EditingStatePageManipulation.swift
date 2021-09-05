//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

extension EditingState {
    func replacingCurrentPage(with newPage: Page) -> EditingState {
        let newDocument = document.replacingPage(atIndex: currentPageIndex, with: newPage)
        return EditingState.Lenses.document.set(newDocument, self)
    }

    func addingNewPage() -> EditingState {
        let newIndex = document.pages.count
        let newDocument = document.insertingBlankPage(at: newIndex)
        return EditingState.Lenses.document.set(newDocument, self)
    }

    func duplicating(_ page: Page) -> EditingState {
        return EditingState.Lenses.document.set(document.duplicating(page), self)
    }

    func removing(_ page: Page) -> EditingState {
        let midState = EditingState.Lenses.document.set(document.deleting(page), self)
        return EditingState.Lenses.currentPageIndex.set(min(currentPageIndex, document.pages.count - 1), midState)
    }
}
