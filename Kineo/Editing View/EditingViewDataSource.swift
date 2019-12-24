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
        let traitCollection = UITraitCollection.current.withLightInterfaceStyle
        let drawing = documentEditor.page(at: index).drawing
        var thumbnailImage: UIImage?

        traitCollection.performAsCurrent {
            let scale = Self.thumbnailSize / Constants.canvasRect * traitCollection.displayScale
            thumbnailImage = drawing.image(from: Constants.canvasRect, scale: scale)
        }

        return thumbnailImage
    }

    // MARK: Boilerplate

    private static let thumbnailSize = CGSize(width: 36, height: 36)

    private let documentEditor: DocumentEditor
    private let skinGenerator = SkinGenerator()
}
