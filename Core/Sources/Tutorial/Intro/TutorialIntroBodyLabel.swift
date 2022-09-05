//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroBodyLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        font = .appFont(forTextStyle: .callout)
        numberOfLines = 0
        attributedText = text.correctlyPronounced.symbolized
        textColor = .tutorialIntroText
        translatesAutoresizingMaskIntoConstraints = false
        setContentCompressionResistancePriority(.required, for: .vertical)
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

extension String {
    var correctlyPronounced: NSAttributedString {
        let range = (self as NSString).range(of: "Kineo")
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.accessibilitySpeechIPANotation, value: "ˈkɪ.ni.o͡ʊ", range: range)
        return attributedString
    }
}

extension NSAttributedString {
    var symbolized: NSAttributedString {
        do {
            let regex = try NSRegularExpression(pattern: "\\$(?<systemName>[a-z0-9\\.]*)\\$", options: [])
            let newString = NSMutableAttributedString(attributedString: self)
            while true {
                guard let match = regex.firstMatch(in: newString.string, options: [], range: NSRange(location: 0, length: newString.length)) else { break }
                let range = match.range

                let captureRange = match.range(withName: "systemName")
                let systemName = newString.attributedSubstring(from: captureRange).string
                if let systemImage = UIImage(systemName: systemName) {
                    let symbolString = NSAttributedString(attachment: NSTextAttachment(image: systemImage))
                    newString.replaceCharacters(in: range, with: symbolString)
                } else {
                    newString.replaceCharacters(in: range, with: "")
                }
            }
            return newString
        } catch {
            return self
        }
    }
}

