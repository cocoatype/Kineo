//  Created by Geoff Pado on 7/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

enum Icons {
    static let export = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let play = UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let nextPage = UIImage(systemName: "arrowshape.turn.up.right", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let previousPage = UIImage(systemName: "arrowshape.turn.up.left", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let gallery = UIImage(systemName: "square.grid.2x2", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let tools = UIImage(systemName: "pencil.tip.crop.circle", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let undo = UIImage(systemName: "arrow.uturn.left", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let redo = UIImage(systemName: "arrow.uturn.right", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let help = UIImage(systemName: "questionmark", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)

    static let newDocument = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))

    static let newPage = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .medium))

    enum ContextMenu {
        static let delete = UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration.contextMenuIconConfiguration)
        static let export = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage.SymbolConfiguration.contextMenuIconConfiguration)
    }
}

extension UIImage.SymbolConfiguration {
    static let sidebarIconConfiguration = UIImage.SymbolConfiguration(scale: .large).applying(UIImage.SymbolConfiguration(weight: .medium))

    static let contextMenuIconConfiguration = UIImage.SymbolConfiguration(scale: .default)
}