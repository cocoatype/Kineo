//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

extension EditingState {
    func settingBackgroundColor(to color: UIColor) -> EditingState {
        let newDocument = document.settingBackgroundColorHex(to: color.hex)
        return EditingState.Lenses.document.set(newDocument, self)
    }

    func settingBackgroundImageData(to data: Data?) -> EditingState {
        let newDocument = document.settingBackgroundImage(from: data)
        return EditingState.Lenses.document.set(newDocument, self)
    }

    func replacingCurrentPage(with newPage: Page) -> EditingState {
        let newDocument = document.replacingPage(atIndex: currentPageIndex, with: newPage)
        return EditingState.Lenses.document.set(newDocument, self)
    }

    func addingNewPage() -> EditingState {
        let newIndex = document.pages.count
        let newDocument = document.insertingBlankPage(at: newIndex)
        let midState = EditingState.Lenses.document.set(newDocument, self)
        return EditingState.Lenses.currentPageIndex.set(newIndex, midState)
    }

    func duplicating(_ page: Page) -> EditingState {
        return EditingState.Lenses.document.set(document.duplicating(page), self)
    }

    func removing(_ page: Page) -> EditingState {
        let newDocument = document.deleting(page)
        let midState = EditingState.Lenses.document.set(newDocument, self)
        return EditingState.Lenses.currentPageIndex.set(min(currentPageIndex, newDocument.pages.count - 1), midState)
    }

    func movingPage(at sourceIndex: Int, to destinationIndex: Int) -> EditingState {
        return EditingState.Lenses.document.set(document.movingPage(at: sourceIndex, to: destinationIndex), self)
    }
}
