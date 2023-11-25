//  Created by Geoff Pado on 9/3/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStatePhone
import SwiftUI

public class FilmStripHostingController: UIHostingController<FilmStrip> {
    public init(editingStatePublisher: EditingStatePublisher) {
        super.init(rootView: FilmStrip(editingStatePublisher: editingStatePublisher))
    }

    public override func viewDidLoad() {
        view.backgroundColor = .clear
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
