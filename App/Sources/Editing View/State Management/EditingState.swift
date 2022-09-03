//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import Foundation

typealias EditingStatePublisher = CascadingPublisher<EditingState>

struct EditingState: Equatable {
    let currentPageIndex: Int
    let document: Document
    let mode: Mode
    let toolPickerShowing: Bool

    init(document: Document) {
        self.currentPageIndex = 0
        self.document = document
        self.mode = .editing
        self.toolPickerShowing = false
    }

    var currentPage: Page { page(at: currentPageIndex) }
    var pageCount: Int { document.pages.count }
    func page(at index: Int) -> Page { document.pages[index] }
}
