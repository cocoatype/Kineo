//  Created by Geoff Pado on 8/21/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import DataPhone
import UIKit

class DocumentThumbnailProvider: NSItemProvider {
    init(document: Document) {
        super.init()
        registerObject(ofClass: UIImage.self, visibility: .all) { handler -> Progress? in
            Task {
                let image = await SkinGenerator().generatePreviewImage(from: document)
                handler(image, nil)
            }
            return nil
        }
    }
}
