//  Created by Geoff Pado on 3/2/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 15, *)
struct TutorialOnboardingHeader: View {
    init(_ string: String) {
        self.string = string
    }

    var body: some View {
        Text(attributedString)
            .font(Font(UIFont.appFont(forTextStyle: .largeTitle)))
            .foregroundColor(Color(.tutorialIntroText))
    }

    private var attributedString: AttributedString {
        let lines = string.split(separator: "\n")
        var attributedLines = lines.map { AttributedString($0).correctlyPronounced }

        if var lastLine = attributedLines.popLast() {
            lastLine.foregroundColor = Color(uiColor: .tutorialIntroAccent)
            attributedLines.append(lastLine)
        }

        return attributedLines.reduce(into: AttributedString()) { partialResult, attributedLine in
            if partialResult != AttributedString() {
                partialResult.append(AttributedString("\n"))
            }

            partialResult.append(attributedLine)
        }
    }

    private let string: String
}

@available(iOS 15, *)
struct TutorialOnboardingHeaderPreview: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            TutorialOnboardingHeader("Welcome to\nKineo")
            TutorialOnboardingHeader("Play")
        }
    }
}
