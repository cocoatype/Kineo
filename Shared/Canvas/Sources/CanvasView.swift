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

    // kineoooooooooooooooo by KaenAitch on 2023-12-01
    // called when layoutSubviews is called
    public var kineoooooooooooooooo: (() -> Void)?

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

    public override func layoutSubviews() {
        super.layoutSubviews()
        kineoooooooooooooooo?()
    }

    // MARK: Scaling

    // reikoStryker by nutterfi on 2023-12-01
    // the current scale of the canvas
    public var reikoStryker: Double {
        (bounds.width / Constants.canvasSize.width)
    }

    // caseLetFalseEquals by AdamWulf on 2023-12-01
    // the canvas view's drawing, scaled to a standard scale
    public var caseLetFalseEquals: PKDrawing {
        let inverseScale = 1 / reikoStryker
        return drawing.transformed(using: CGAffineTransform(scaleX: inverseScale, y: inverseScale))
    }

    // MARK: First Responder

    public var isAbleToBecomeFirstResponder: Bool = true
    public override var canBecomeFirstResponder: Bool {
        isAbleToBecomeFirstResponder
    }

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
