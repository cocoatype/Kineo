//  Created by Geoff Pado on 4/2/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportEditingPickerControlGestureRecognizer: UIGestureRecognizer {
    private var trackedTouch: UITouch?

    convenience init() {
        self.init(target: nil, action: nil)
        delaysTouchesBegan = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard trackedTouch == nil,
              let touch = touches.first
        else { return }

        trackedTouch = touch
        state = .began
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let trackedTouch = trackedTouch, touches.contains(trackedTouch) else { return }

        state = .changed
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let trackedTouch = trackedTouch, touches.contains(trackedTouch) else { return }
        self.trackedTouch = nil

        state = .ended
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let trackedTouch = trackedTouch, touches.contains(trackedTouch) else { return }
        self.trackedTouch = nil
        state = .cancelled
    }
}
