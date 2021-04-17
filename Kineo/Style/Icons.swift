//  Created by Geoff Pado on 7/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

enum Icons {
    static let export = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let play = UIImage(systemName: "play", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let pause = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let nextPage = UIImage(systemName: "arrowshape.turn.up.right", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let previousPage = UIImage(systemName: "arrowshape.turn.up.left", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let gallery = UIImage(systemName: "square.grid.2x2", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let tools = UIImage(systemName: "pencil.tip.crop.circle", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let undo = UIImage(systemName: "arrow.uturn.left", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let redo = UIImage(systemName: "arrow.uturn.right", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    static let help = UIImage(systemName: "questionmark", withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)

    static let newDocument = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))

    static let newPage = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .medium))

    static let exportSettings = UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(pointSize: activityIconSize))

    enum ContextMenu {
        private static func contextMenuImage(systemName: String) -> UIImage? {
            return UIImage(systemName: systemName, withConfiguration: UIImage.SymbolConfiguration.contextMenuIconConfiguration)
        }

        static let delete = contextMenuImage(systemName: "trash")
        static let export = contextMenuImage(systemName: "square.and.arrow.up")
        static let window = contextMenuImage(systemName: "square.split.2x1")

        static let loop = contextMenuImage(systemName: Names.loop)
        static let bounce = contextMenuImage(systemName: Names.bounce)
    }

    enum Export {
        private static func exportPickerImage(systemName: String) -> UIImage? {
            return UIImage(systemName: systemName, withConfiguration: UIImage.SymbolConfiguration.exportPickerIconConfiguration)
        }

        static let square = exportPickerImage(systemName: "square")
        static let squarePlain = exportPickerImage(systemName: "square.dashed")
        static let landscape = exportPickerImage(systemName: "rectangle")
        static let portrait = exportPickerImage(systemName: "rectangle.portrait")

        static let loop = exportPickerImage(systemName: Names.loop)
        static let bounce = exportPickerImage(systemName: Names.bounce)
    }

    private enum Names {
        static let loop = "arrow.2.circlepath"
        static let bounce = "arrow.right.arrow.left"
    }

    private static var activityIconSize = CGFloat(24)
}

private extension UIImage.SymbolConfiguration {
    static let sidebarIconConfiguration = UIImage.SymbolConfiguration(scale: .large).applying(UIImage.SymbolConfiguration(weight: .medium))

    static let contextMenuIconConfiguration = UIImage.SymbolConfiguration(scale: .default)
    static let exportPickerIconConfiguration = UIImage.SymbolConfiguration(pointSize: 24)
}
