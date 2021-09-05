//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

enum EditingPageReplacement {
    static func updatedState(from originalState: EditingState, replacingCurrentPageWith newPage: Page) -> EditingState {
        let newDocument = originalState.document.replacingPage(atIndex: originalState.currentPageIndex, with: newPage)
        return EditingState.Lenses.document.set(newDocument, originalState)
    }
}

enum EditingPageAddition {
    static func updatedState(from originalState: EditingState) -> EditingState {
        let originalDocument = originalState.document
        let newIndex = originalDocument.pages.count
        let newDocument = originalDocument.insertingBlankPage(at: newIndex)
        return EditingState.Lenses.document.set(newDocument, originalState)
    }
}

enum EditingPageDuplication {
    static func updatedState(from originalState: EditingState, duplicating page: Page) -> EditingState {
        let newDocument = originalState.document.duplicating(page)
        return EditingState.Lenses.document.set(newDocument, originalState)
    }
}
