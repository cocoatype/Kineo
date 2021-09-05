//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

enum EditingViewFactory {
    static func editingView(for traitCollection: UITraitCollection, drawingViewController: DrawingViewController, statePublisher: EditingStatePublisher) -> EditingView {
        #warning("replace with logic to find view")
        return CompactEditingView(statePublisher: statePublisher, drawingViewController: drawingViewController)
    }
}
