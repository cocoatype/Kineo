//  Created by Geoff Pado on 9/2/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class DrawingViewController: UIViewController {
    init(publisher: EditingStatePublisher) {
        self.drawingView = DrawingView(statePublisher: publisher)
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = drawingView
    }

    // MARK: Boilerplate

    let drawingView: DrawingView

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
