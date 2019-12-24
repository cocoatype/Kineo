//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

public class DocumentEditor: NSObject {
    public init(document: Document) {
        self.document = document
        super.init()
    }

    public var currentPage: Page {
        return document.pages[currentIndex]
    }

    public var pageCount: Int {
        return document.pages.count
    }

    // MARK: Editing

    func addPage() {
        let newIndex = currentIndex + 1
        document = document.insertingBlankPage(at: newIndex)
        currentIndex = newIndex
        documentStore.save(document)
    }

    public func replaceCurrentPage(with newPage: Page) {
        document = document.replacingPage(atIndex: currentIndex, with: newPage)
        documentStore.save(document)
    }

    // MARK: Navigation

    public var advancingWouldCreateNewPage: Bool {
        let lastPageIndex = document.pages.endIndex - 1
        let currentPage = document.pages[currentIndex]
        return currentIndex == lastPageIndex && currentPage.hasDrawing
    }

    public func advancePage() {
        if advancingWouldCreateNewPage {
            addPage()
        } else {
            currentIndex = min(currentIndex + 1, document.pages.endIndex - 1)
        }
    }

    public func retreatPage() {
        currentIndex = max(currentIndex - 1, document.pages.startIndex)
    }

    // MARK: Boilerplate

    private let documentStore = DocumentStore()

    private(set) public var document: Document
    private(set) public var currentIndex = 0
}
