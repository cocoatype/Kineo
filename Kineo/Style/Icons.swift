//  Created by Geoff Pado on 7/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

enum Icons {
    static let background = standardIcon(named: "square.2.stack.3d.bottom.filled")
    static let colorBackground = standardIcon(named: "paintpalette")
    static let imageBackground = standardIcon(named: "photo")

    static let export = standardIcon(named: "square.and.arrow.up")
    static let play = standardIcon(named: "play")
    static let pause = standardIcon(named: "pause")
    static let nextPage = standardIcon(named: "arrowshape.turn.up.right")
    static let previousPage = standardIcon(named: "arrowshape.turn.up.left")
    static let gallery = standardIcon(named: "square.grid.2x2")
    static let tools = standardIcon(named: "pencil.tip.crop.circle")
    static let undo = standardIcon(named: "arrow.uturn.left")
    static let redo = standardIcon(named: "arrow.uturn.right")
    static let help = standardIcon(named: "questionmark")
    static let menu = standardIcon(named: "ellipsis.circle")

    static let newDocument = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))

    static let newPage = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .medium))

    static let exportSettings = UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(pointSize: activityIconSize))

    private static func standardIcon(named systemName: String) -> UIImage? {
        UIImage(systemName: systemName, withConfiguration: UIImage.SymbolConfiguration.sidebarIconConfiguration)
    }

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
