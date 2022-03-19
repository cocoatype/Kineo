//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroHeaderLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        adjustsFontSizeToFitWidth = true
        allowsDefaultTighteningForTruncation = true
        font = .appFont(forTextStyle: .largeTitle)
        minimumScaleFactor = 0.9
        numberOfLines = 0
        textColor = .tutorialIntroText
        translatesAutoresizingMaskIntoConstraints = false
        setContentCompressionResistancePriority(.required, for: .vertical)

        let lines = text.split(separator: "\n")
        var attributedLines = lines.compactMap { String($0).correctlyPronounced.mutableCopy() as? NSMutableAttributedString }

        if let lastLine = attributedLines.popLast() {
            lastLine.addAttribute(.foregroundColor, value: UIColor.tutorialIntroAccent, range: NSRange(location: 0, length: lastLine.length))
            attributedLines.append(lastLine)
        }

        attributedText = attributedLines.reduce(into: NSMutableAttributedString()) { partialResult, attributedLine in
            if partialResult.length != 0 {
                partialResult.append(NSAttributedString(string: "\n"))
            }

            partialResult.append(attributedLine)
        }
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
