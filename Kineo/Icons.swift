//  Created by Geoff Pado on 7/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

enum Icons {
    static let export = UIImage(systemName: "square.and.arrow.up.fill", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let nextPage = UIImage(systemName: "arrowshape.turn.up.right.fill", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let previousPage = UIImage(systemName: "arrowshape.turn.up.left.fill", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let gallery = UIImage(systemName: "square.grid.2x2.fill", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)

    static let newDocument = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
}

extension UIImage.SymbolConfiguration {
    static let sidebarIconConfiguration = UIImage.SymbolConfiguration(scale: .large).applying(UIImage.SymbolConfiguration(weight: .bold))
}
