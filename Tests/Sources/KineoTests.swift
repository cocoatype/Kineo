//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import XCTest
@testable import Kineo

class IconTests: XCTestCase {
    func testCreatingEveryIcon() {
        let icons = [Icons.background, Icons.export, Icons.play, Icons.pause, Icons.nextPage, Icons.previousPage, Icons.gallery, Icons.tools, Icons.undo, Icons.redo, Icons.help, Icons.menu, Icons.newDocument, Icons.newPage, Icons.exportSettings, Icons.ContextMenu.delete, Icons.ContextMenu.export, Icons.ContextMenu.bounce, Icons.ContextMenu.loop, Icons.ContextMenu.window, Icons.Export.square, Icons.Export.squarePlain, Icons.Export.landscape, Icons.Export.portrait, Icons.Export.loop, Icons.Export.bounce]

        icons.enumerated().forEach { (index, image) in
            XCTAssertNotNil(image, "image at index \(index) was nil")
        }
    }
}
