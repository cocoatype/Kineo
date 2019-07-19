//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

struct Document: Codable {
    init() {
        self.init(pages: [Page()])
    }

    init(pages: [Page]) {
        self.pages = pages
    }

    func replacingPage(atIndex index: Int, with page: Page) -> Document {
        var newPages = pages
        newPages[index] = page
        return Document(pages: newPages)
    }

    func insertingBlankPage(at index: Int) -> Document {
        var newPages = pages
        newPages.insert(Page(), at: index)
        return Document(pages: newPages)
    }

    private static var samplePage: Page? {
        guard let resourceURL = Bundle.main.url(forResource: "example", withExtension: "json"),
          let data = try? Data(contentsOf: resourceURL),
          let page = try? JSONDecoder().decode(Page.self, from: data)
        else { return nil }

        return page
    }

    let pages: [Page]
}
