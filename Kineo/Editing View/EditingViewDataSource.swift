//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class EditingViewDataSource: NSObject {
    init(documentEditor: DocumentEditor) {
        self.documentEditor = documentEditor
    }

    func generateSkinsImage(_ completionHandler: @escaping ((UIImage?) -> Void)) {
        skinGenerator.generateSkinsImage(from: documentEditor.document, currentPageIndex: documentEditor.currentIndex) { image in
            completionHandler(image)
        }
    }

    var currentPage: Page { return documentEditor.currentPage }
    var currentPageIndex: Int { return documentEditor.currentIndex }
    var pageCount: Int { return documentEditor.pageCount }
    var document: Document { return documentEditor.document }

    func page(at index: Int) -> Page {
        return document.pages[index]
    }

    // MARK: Boilerplate

    private let documentEditor: DocumentEditor
    private let skinGenerator = SkinGenerator()
}
