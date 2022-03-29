//  Created by Geoff Pado on 11/10/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIColor {
    convenience init?(hexString: String?) {
        guard let hexString = hexString, let hexLiteral = Int(hexString, radix: 16) else {
            return nil
        }

        self.init(hexLiteral: hexLiteral)
    }

    convenience init(hexLiteral hex: Int) {
        let red = CGFloat((hex & 0xFF0000) >> 16)
        let green = CGFloat((hex & 0x00FF00) >> 8)
        let blue = CGFloat((hex & 0x0000FF) >> 0)

        self.init(red: red / 255,
          green: green / 255,
          blue: blue / 255,
          alpha: 1.0)
    }

    var hex: String {
        var red = CGFloat.zero
        var green = CGFloat.zero
        var blue = CGFloat.zero

        getRed(&red, green: &green, blue: &blue, alpha: nil)

        let redInt = Int((red * 255).rounded())
        let greenInt = Int((green * 255).rounded())
        let blueInt = Int((blue * 255).rounded())

        let redHex = String(format: "%02x", redInt)
        let greenHex = String(format: "%02x", greenInt)
        let blueHex = String(format: "%02x", blueInt)

        return "\(redHex)\(greenHex)\(blueHex)"
    }

    private static func named(_ name: String) -> UIColor {
        guard let color = self.init(named: name) else { fatalError("Couldn't load color named: \(name)") }
        return color
    }

    static let appBackground = UIColor.named("Background")
    static let appShadow = UIColor.named("Shadow")
    static let canvasBackground = UIColor.named("Canvas Background")
    static let canvasBorder = UIColor.named("Canvas Border")
    static let canvasShadowDark = UIColor.named("Canvas Shadow Dark")
    static let canvasShadowLight = UIColor.named("Canvas Shadow Light")
    static let cellTitle = UIColor.named("Cell Title")
    static let exportAccent = UIColor.named("Export Accent")
    static let filmStripBackground = UIColor.named("Film Strip Background")
    static let filmStripBorder = UIColor.named("Film Strip Border")
    static let filmStripIndicator = UIColor.named("Film Strip Indicator")
    static let filmStripShadowDark = UIColor.named("Film Strip Shadow Dark")
    static let filmStripShadowLight = UIColor.named("Film Strip Shadow Light")
    static let newCellTint = UIColor.named("New Document Cell Tint")
    static let settingsCellBackground = UIColor.named("Settings Cell Background")
    static let settingsRowTint = UIColor.named("Settings Row Tint")
    static let sidebarBackground = UIColor.named("Sidebar Background")
    static let sidebarBorder = UIColor.named("Sidebar Border")
    static let sidebarButtonBackground = UIColor.named("Sidebar Button Background")
    static let sidebarButtonBackgroundSelected = UIColor.named("Sidebar Button Background (Selected)")
    static let sidebarButtonBorder = UIColor.named("Sidebar Button Border")
    static let sidebarButtonHighlight = UIColor.named("Sidebar Button Highlight")
    static let sidebarButtonShadowDark = UIColor.named("Sidebar Button Shadow Dark")
    static let sidebarButtonShadowLight = UIColor.named("Sidebar Button Shadow Light")
    static let sidebarButtonTint = UIColor.named("Sidebar Button Tint")

    static let tutorialIntroAccent = UIColor.named("Tutorial Intro Accent")
    static let tutorialIntroDismissButtonTitle = UIColor.named("Tutorial Intro Dismiss Button Title")
    static let tutorialIntroStartButtonTitle = UIColor.named("Tutorial Intro Start Button Title")
    static let tutorialIntroText = UIColor.named("Tutorial Intro Text")

    static let controlTint = UIColor.named("Web Control Tint")

    static let darkSystemBackgroundSecondary = UIColor.secondarySystemBackground.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark))
}
