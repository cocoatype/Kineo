//  Created by Geoff Pado on 8/21/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class DocumentThumbnailProvider: NSItemProvider {
    init(document: Document) {
        super.init()
        registerObject(ofClass: UIImage.self, visibility: .all) { handler -> Progress? in
            SkinGenerator().generatePreviewImage(from: document) { image in
                handler(image, nil)
            }
            return nil
        }
    }
}
