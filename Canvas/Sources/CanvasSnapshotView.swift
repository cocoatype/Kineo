//  Created by Geoff Pado on 4/29/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS) && !os(visionOS)
import DataPhone
#elseif os(visionOS)
import DataVision
#endif

import PencilKit
import UIKit

class CanvasSnapshotView: UIImageView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        contentMode = .scaleAspectFill
        layer.cornerRadius = Constants.canvasCornerRadius
        isHidden = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
    }

    func setSnapshot(from drawing: PKDrawing) {
        UITraitCollection.current.withLightInterfaceStyle.performAsCurrent {
            image = drawing.image(from: Constants.canvasRect, scale: 1)
            isHidden = false
        }
    }

    func clearSnapshot() {
        image = nil
        isHidden = true
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
