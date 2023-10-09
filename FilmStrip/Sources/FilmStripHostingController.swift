//  Created by Geoff Pado on 9/3/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStatePhone
import SwiftUI

class FilmStripHostingController<FilmStripType: FilmStrip>: UIHostingController<FilmStripType> {
    init(editingStatePublisher: EditingStatePublisher) {
        super.init(rootView: FilmStripType(editingStatePublisher: editingStatePublisher))
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
