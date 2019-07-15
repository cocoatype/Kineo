//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import PencilKit

struct Document: Codable {
    init() {
        self.pages = [(Document.samplePage ?? Page())]
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

struct Page: Codable {
    init(drawing: PKDrawing? = nil) {
        self.drawing = drawing ?? PKDrawing()
    }

    let drawing: PKDrawing
}
