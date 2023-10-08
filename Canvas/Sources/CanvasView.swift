//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

#if os(iOS) && !os(visionOS)
import DataPhone
#elseif os(visionOS)
import DataVision
#endif

import PencilKit

public class CanvasView: PKCanvasView {
    public var onFirstResponderChange: (() -> Void)?

    public init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        isOpaque = false
        layer.cornerRadius = Constants.canvasCornerRadius
        overrideUserInterfaceStyle = .light
        translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 14.0, *) {
            drawingPolicy = .anyInput
        }
    }

    // MARK: First Responder

    override public func becomeFirstResponder() -> Bool {
        let value = super.becomeFirstResponder()
        onFirstResponderChange?()
        return value
    }

    override public func resignFirstResponder() -> Bool {
        let value = super.resignFirstResponder()
        onFirstResponderChange?()
        return value
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
