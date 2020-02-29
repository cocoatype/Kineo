//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

public class DocumentEditor: NSObject {
    public init(document: Document) {
        self.document = document
        super.init()
    }

    public var currentPage: Page {
        return page(at: currentIndex)
    }

    public var pageCount: Int {
        return document.pages.count
    }

    public func page(at index: Int) -> Page {
        return document.pages[index]
    }

    private(set) public var currentIndex = 0
    public var document: Document {
        didSet(oldDocument) {
            assertUndoManagerExists()
            undoManager?.registerUndo(withTarget: self) { [weak self, oldDocument, currentIndex] _ in
                self?.document = oldDocument
                self?.currentIndex = currentIndex
            }
        }
    }

    // MARK: Editing

    public func addNewPage() {
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

    public func navigate(toPageAt index: Int) {
        guard index >= 0, index < pageCount else { return }
        currentIndex = index
    }

    // MARK: Undo/Redo

    public var undoManager: UndoManager?

//    public func undo() { documentUndoManager.undo() }
//    public func redo() { documentUndoManager.redo() }

    // MARK: Boilerplate

    private let documentStore = DocumentStore()
    private func assertUndoManagerExists() {
        assert(undoManager != nil, "undo manager was nil")
    }
}
