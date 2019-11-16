//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class SidebarActionStackView: UIStackView {
    init(_ actions: [SidebarAction]) {
        super.init(frame: .zero)
        
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false

        actions.map(SidebarActionButton.init).forEach(addArrangedSubview(_:))
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
