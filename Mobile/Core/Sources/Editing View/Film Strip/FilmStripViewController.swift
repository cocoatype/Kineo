//  Created by Geoff Pado on 10/14/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStatePhone
import UIKit

class FilmStripViewController: UIViewController {
    private let statePublisher: EditingStatePublisher
    init(statePublisher: EditingStatePublisher) {
        self.statePublisher = statePublisher
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = FilmStripView(statePublisher: statePublisher)
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
