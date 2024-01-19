//  Created by Geoff Pado on 5/12/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataPhone
import UIKit

class GIFProvider: UIActivityItemProvider {
    static func exportedURL(from document: Document) throws -> URL {
        return try GIFExporter.exportGIF(from: document)
    }
}
