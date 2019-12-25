//  Created by Geoff Pado on 11/10/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIColor {
    private static func named(_ name: String) -> UIColor {
        guard let color = self.init(named: name) else { fatalError("Couldn't load color named: \(name)") }
        return color
    }

    static let appBackground = UIColor.named("Background")
    static let appShadow = UIColor.named("Shadow")
    static let canvasBackground = UIColor.named("Canvas Background")
    static let cellTitle = UIColor.named("Cell Title")
    static let filmStripBackground = UIColor.named("Film Strip Background")
    static let filmStripIndicator = UIColor.named("Film Strip Indicator")
    static let newCellTint = UIColor.named("New Document Cell Tint")
    static let sidebarBackground = UIColor.named("Sidebar Background")
    static let sidebarBorder = UIColor.named("Sidebar Border")
    static let sidebarButtonBackground = UIColor.named("Sidebar Button Background")
    static let sidebarButtonTint = UIColor.named("Sidebar Button Tint")
}
