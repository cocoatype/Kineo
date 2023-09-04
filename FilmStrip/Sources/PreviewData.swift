//  Created by Geoff Pado on 9/3/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Combine
import Data
import EditingState

enum PreviewData {
    static let editingStatePublisher = EditingStatePublisher(initialValue: editingState)
    static let editingState = EditingState(document: Document(pages: [Page()], backgroundColorHex: nil, backgroundImageData: nil))
}
