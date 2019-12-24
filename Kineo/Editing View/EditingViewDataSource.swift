//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class EditingViewDataSource: NSObject {
    init(documentEditor: DocumentEditor) {
        self.documentEditor = documentEditor
    }

    var skinsImage: UIImage? { return skinGenerator.skinsImage(from: documentEditor.document, currentPageIndex: documentEditor.currentIndex) }
    var currentPage: Page { return documentEditor.currentPage }
    var currentPageIndex: Int { return documentEditor.currentIndex }
    var pageCount: Int { return documentEditor.pageCount }

    func thumbnail(forPageAt index: Int) -> UIImage? {
        return nil
    }

    // MARK: Boilerplate
    private let documentEditor: DocumentEditor
    private let skinGenerator = SkinGenerator()
}

