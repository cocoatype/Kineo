//  Created by Geoff Pado on 3/2/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 15, *)
struct TutorialOnboardingText: View {
    init(_ string: String) {
        self.string = string
    }

    var body: some View {
//        Text(AttributedString(string.symbolized).correctlyPronounced)
        Text(AttributedString("this is a button: \(Image(systemName: "bolt"))"))
            .font(Font(UIFont.appFont(forTextStyle: .callout)))
    }

    private let string: String
}

@available(iOS 15, *)
extension AttributedString {
    var correctlyPronounced: AttributedString {
        guard let range = range(of: "Kineo") else { return self }

        var correctlyPronouncedSubstring = AttributedString("Kineo")
        correctlyPronouncedSubstring.accessibilitySpeechPhoneticNotation = "ˈkɪ.ni.o͡ʊ"

        var newString = self
        newString.replaceSubrange(range, with: correctlyPronouncedSubstring)
        return newString
    }
}

extension String {
    var symbolized: String {
        do {
            let regex = try NSRegularExpression(pattern: "\\$(?<systemName>[a-z\\.]*)\\$", options: [])
            var newString = self
            while true {
                guard let match = regex.firstMatch(in: newString, options: [], range: NSRange(location: 0, length: newString.utf16.count)) else { break }
                let range = match.range
                let captureRange = match.range(withName: "systemName")
                let systemName = (newString as NSString).substring(with: captureRange)
                newString = (newString as NSString).replacingCharacters(in: range, with: "\(Image(systemName: systemName))")
            }
            return newString
        } catch {
            return self
        }
    }
}
