//  Created by Geoff Pado on 11/10/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import SwiftUI
import UIKit

public extension UIColor {
    convenience init?(hexString: String?) {
        guard let hexString = hexString, let hexLiteral = Int(hexString, radix: 16) else {
            return nil
        }

        if hexString.count == 6 {
            self.init(rgbHexLiteral: hexLiteral)
        } else if hexString.count == 8  {
            self.init(rgbaHexLiteral: hexLiteral)
        } else { return nil }
    }

    private convenience init(rgbHexLiteral hex: Int) {
        let red = CGFloat((hex & 0xFF0000) >> 16)
        let green = CGFloat((hex & 0x00FF00) >> 8)
        let blue = CGFloat((hex & 0x0000FF) >> 0)

        self.init(red: red / 255,
          green: green / 255,
          blue: blue / 255,
          alpha: 1.0)
    }

    private convenience init(rgbaHexLiteral hex: Int) {
        let red = CGFloat((hex & 0xFF000000) >> 24)
        let green = CGFloat((hex & 0x00FF0000) >> 16)
        let blue = CGFloat((hex & 0x0000FF00) >> 8)
        let alpha = CGFloat((hex & 0x000000FF) >> 0)

        self.init(red: red / 255,
          green: green / 255,
          blue: blue / 255,
          alpha: alpha / 255)
    }

    var hex: String {
        var red = CGFloat.zero
        var green = CGFloat.zero
        var blue = CGFloat.zero
        var alpha = CGFloat.zero

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let redInt = Int((red * 255).rounded())
        let greenInt = Int((green * 255).rounded())
        let blueInt = Int((blue * 255).rounded())
        let alphaInt = Int((alpha * 255).rounded())

        let redHex = String(format: "%02x", redInt)
        let greenHex = String(format: "%02x", greenInt)
        let blueHex = String(format: "%02x", blueInt)
        let alphaHex = String(format: "%02x", alphaInt)

        return "\(redHex)\(greenHex)\(blueHex)\(alphaHex)"
    }
}

private class BundleFinder {}
