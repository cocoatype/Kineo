//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

public struct Document: Codable, Equatable {
    init() {
        self.init(pages: [Page()], uuid: UUID())
    }

    init(pages: [Page], uuid: UUID) {
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

    public let pages: [Page]
    public let uuid: UUID

    // MARK: Equatable

    public static func == (lhs: Document, rhs: Document) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
