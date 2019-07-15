//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

class DocumentEditor: NSObject {
    init(document: Document) {
        self.document = document
        super.init()
    }

    func replaceCurrentPage(with newPage: Page) {
        document = document.replacingPage(atIndex: currentIndex, with: newPage)
        documentStore.save(document)
    }

    // MARK: Boilerplate

    private let documentStore = DocumentStore()

    private var document: Document
    private var currentIndex = 0
    var currentPage: Page {
        return document.pages[currentIndex]
    }
}
