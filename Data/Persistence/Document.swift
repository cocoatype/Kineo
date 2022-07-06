//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

public struct Document: Codable, Equatable {
    public init(pages: [Page], backgroundColorHex: String?, backgroundImageData: Data?) {
        self.init(pages: pages, uuid: UUID(), backgroundColorHex: backgroundColorHex, backgroundImageData: backgroundImageData)
    }

    init(pages: [Page] = [Page()], uuid: UUID = UUID(), backgroundColorHex: String? = nil, backgroundImageData: Data? = nil) {
        self.backgroundColorHex = backgroundColorHex
        self.backgroundImageData = backgroundImageData
        self.pages = pages
        self.uuid = uuid
    }

    public func settingBackgroundColorHex(to newHex: String) -> Document {
        return Document(pages: self.pages, uuid: self.uuid, backgroundColorHex: newHex, backgroundImageData: backgroundImageData)
    }

    public func settingBackgroundImage(from imageData: Data?) -> Document {
        return Document(pages: pages, uuid: uuid, backgroundColorHex: self.backgroundColorHex, backgroundImageData: imageData)
    }

    public func replacingPage(atIndex index: Int, with page: Page) -> Document {
        var newPages = pages
        newPages[index] = page
        return Document(pages: newPages, uuid: self.uuid, backgroundColorHex: self.backgroundColorHex, backgroundImageData: self.backgroundImageData)
    }

    public func insertingBlankPage(at index: Int) -> Document {
        var newPages = pages
        newPages.insert(Page(), at: index)
        return Document(pages: newPages, uuid: self.uuid, backgroundColorHex: self.backgroundColorHex, backgroundImageData: self.backgroundImageData)
    }

    public func movingPage(at sourceIndex: Int, to destinationIndex: Int) -> Document {
        let newPages = pages.moving(from: sourceIndex, to: destinationIndex)
        return Document(pages: newPages, uuid: self.uuid, backgroundColorHex: self.backgroundColorHex, backgroundImageData: self.backgroundImageData)
    }

    public func duplicating(_ page: Page) -> Document {
        guard let index = pages.firstIndex(of: page) else { return self }
        let duplicatePage = Page(drawing: page.drawing)
        var newPages = pages
        newPages.insert(duplicatePage, at: pages.index(after: index))
        return Document(pages: newPages, uuid: self.uuid, backgroundColorHex: self.backgroundColorHex, backgroundImageData: self.backgroundImageData)
    }

    public func deleting(_ page: Page) -> Document {
        guard let index = pages.firstIndex(of: page) else { return self }
        var newPages = pages
        newPages.remove(at: index)
        return Document(pages: newPages, uuid: self.uuid, backgroundColorHex: self.backgroundColorHex, backgroundImageData: self.backgroundImageData)
    }

    public let backgroundColorHex: String?
    public let backgroundImageData: Data?
    public let pages: [Page]
    public let uuid: UUID
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
