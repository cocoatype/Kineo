//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

public struct Document: Codable, Equatable {
    public init(pages: [Page]) {
        self.init(pages: pages, uuid: UUID())
    }

    init(pages: [Page] = [Page()], uuid: UUID = UUID()) {
        self.pages = pages
        self.uuid = uuid
    }

    func replacingPage(atIndex index: Int, with page: Page) -> Document {
        var newPages = pages
        newPages[index] = page
        return Document(pages: newPages, uuid: self.uuid)
    }

    func insertingBlankPage(at index: Int) -> Document {
        var newPages = pages
        newPages.insert(Page(), at: index)
        return Document(pages: newPages, uuid: self.uuid)
    }

    func movingPage(at sourceIndex: Int, to destinationIndex: Int) -> Document {
        let newPages = pages.moving(from: sourceIndex, to: destinationIndex)
        return Document(pages: newPages, uuid: self.uuid)
    }

    func duplicating(_ page: Page) -> Document {
        guard let index = pages.firstIndex(of: page) else { return self }
        let duplicatePage = Page(drawing: page.drawing)
        var newPages = pages
        newPages.insert(duplicatePage, at: pages.index(after: index))
        return Document(pages: newPages, uuid: self.uuid)
    }

    func deleting(_ page: Page) -> Document {
        guard let index = pages.firstIndex(of: page) else { return self }
        var newPages = pages
        newPages.remove(at: index)
        return Document(pages: newPages, uuid: self.uuid)
    }

    public let pages: [Page]
    public let uuid: UUID

    // MARK: Equatable

    public static func == (lhs: Document, rhs: Document) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension Array {
    func moving(from oldIndex: Index, to newIndex: Index) -> Self {
        var newArray = self
        // Don't work for free and use swap when indices are next to each other - this
        // won't rebuild array and will be super efficient.
        if oldIndex == newIndex { return self }
        if abs(newIndex - oldIndex) == 1 {
            newArray.swapAt(oldIndex, newIndex)
        } else {
            newArray.insert(newArray.remove(at: oldIndex), at: newIndex)
        }

        return newArray
    }
}
