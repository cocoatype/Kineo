//  Created by Geoff Pado on 9/2/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import EditingStatePhone
#elseif os(visionOS)
import EditingStateVision
#endif

import UIKit

public class DrawingViewController: UIViewController {
    public init(publisher: EditingStatePublisher) {
        self.drawingView = DrawingView(statePublisher: publisher)
        super.init(nibName: nil, bundle: nil)
    }

    public override func loadView() {
        view = drawingView
    }

    // MARK: Boilerplate

    public let drawingView: DrawingView

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
