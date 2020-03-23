//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroHeaderLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.adjustsFontSizeToFitWidth = true
        self.allowsDefaultTighteningForTruncation = true
        self.font = .appFont(forTextStyle: .largeTitle)
        self.minimumScaleFactor = 0.9
        self.numberOfLines = 0
        self.textColor = .tutorialIntroText
        self.translatesAutoresizingMaskIntoConstraints = false

        let lines = text.split(separator: "\n")
        let firstLine = NSAttributedString(string: String(lines[0]))
        let secondLine = NSAttributedString(string: String(lines[1]), attributes: [.foregroundColor: UIColor.tutorialIntroAccent, .accessibilitySpeechIPANotation: "ˈkɪ.ni.o͡ʊ"])

        let tintedString = NSMutableAttributedString(attributedString: firstLine)
        tintedString.append(NSAttributedString(string: "\n"))
        tintedString.append(secondLine)
        self.attributedText = tintedString
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
