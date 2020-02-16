//  Created by Geoff Pado on 2/15/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import Foundation

enum DocumentTransformer {
    static func transformedDocument(from document: Document, using settings: ExportSettings) -> Document {
        switch settings.playbackStyle {
        case .standard: return document
        case .loop: return loopedDocument(from: document, minimumFrameCount: settings.minimumFrameCount)
        case .bounce:
            let base = bouncedDocument(from: document)
            return loopedDocument(from: base, minimumFrameCount: settings.minimumFrameCount)
        }
    }

    private static func bouncedDocument(from document: Document) -> Document {
        let pages = document.pages + document.pages.reversed().dropLast().dropFirst()
        return Document(pages: pages)
    }

    private static func loopedDocument(from document: Document, minimumFrameCount: Int) -> Document {
        let numberOfLoops = Int(ceil(Double(minimumFrameCount) / Double(document.pages.count)))
        let loopedPages = (0..<numberOfLoops).flatMap { _ in return document.pages }
        return Document(pages: loopedPages)
    }
}
