//  Created by Geoff Pado on 11/10/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

public extension UIFont {
    class func appFont(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        let fontMethod: ((UIFont.TextStyle) -> UIFont)
        switch textStyle {
        case .largeTitle:
            fontMethod = blackFont(for:)
        case .headline, .title2:
            fontMethod = boldFont(for:)
        default:
            fontMethod = regularFont(for:)
        }

        let standardFont = fontMethod(textStyle)
        return fontMetrics.scaledFont(for: standardFont)
    }

    class var navigationBarTitleFont: UIFont {
        return boldFont(for: .headline)
    }

    class var navigationBarButtonFont: UIFont {
        return regularFont(for: .subheadline)
    }

    // MARK: Boilerplate

    private static func blackFont(for textStyle: UIFont.TextStyle) -> UIFont {
        return UIFont(descriptor: fontDescriptor(for: textStyle, weight: .black), size: standardFontSize(for: textStyle))
    }

    private static func boldFont(for textStyle: UIFont.TextStyle) -> UIFont {
        return UIFont(descriptor: fontDescriptor(for: textStyle, weight: .bold), size: standardFontSize(for: textStyle))
    }

    private static func regularFont(for textStyle: UIFont.TextStyle) -> UIFont {
        return UIFont(descriptor: fontDescriptor(for: textStyle, weight: .regular), size: standardFontSize(for: textStyle))
    }

    private static func fontDescriptor(for textStyle: UIFont.TextStyle, weight: UIFont.Weight) -> UIFontDescriptor {
        let fallbackFontDescriptor = UIFont.systemFont(ofSize: standardFontSize(for: textStyle), weight: weight).fontDescriptor
        return fallbackFontDescriptor.withDesign(.rounded) ?? fallbackFontDescriptor
    }

    private static func standardFontSize(for textStyle: UIFont.TextStyle) -> CGFloat {
        switch textStyle {
        case .largeTitle: return 34.0
        case .title1: return 28.0
        case .title2: return 22.0
        case .title3: return 20.0
        case .headline: return 17.0
        case .body: return 17.0
        case .callout: return 16.0
        case .subheadline: return 15.0
        case .footnote: return 13.0
        case .caption1: return 12.0
        case .caption2: return 11.0
        default: return 17.0
        }
    }
}

