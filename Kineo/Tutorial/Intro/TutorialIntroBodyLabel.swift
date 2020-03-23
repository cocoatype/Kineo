//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroBodyLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.font = .appFont(forTextStyle: .callout)
        self.numberOfLines = 0
        self.attributedText = correctlyPronounced(text)
        self.textColor = .tutorialIntroText
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func correctlyPronounced(_ string: String) -> NSAttributedString {
        let range = (string as NSString).range(of: "Kineo")
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.accessibilitySpeechIPANotation, value: "ˈkɪ.ni.o͡ʊ", range: range)
        return attributedString
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
