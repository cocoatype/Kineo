//  Created by Geoff Pado on 3/2/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 15, *)
struct TutorialOnboardingIntroPage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 11) {
            TutorialOnboardingHeader(Self.headerText)
            TutorialOnboardingText(Self.bodyText)
            Spacer()
            HStack {
                TutorialOnboardingSecondaryButton("TutorialIntroDismissButton.title", action: {})
                TutorialOnboardingPrimaryButton("TutorialIntroStartButton.title", action: {})
            }
            .frame(maxWidth: .infinity)
        }
        .padding(22)
        .padding(.top, 33)
        .background(Color(uiColor: .appBackground))
        .ignoresSafeArea()
    }

    private static let headerText = NSLocalizedString("TutorialIntroView.headerText", comment: "Header text for the tutorial intro")
    private static let bodyText = NSLocalizedString("TutorialIntroView.bodyText", comment: "Body text for the tutorial intro")
}

@available(iOS 15, *)
struct TutorialOnboardingIntroPagePreview: PreviewProvider {
    static var previews: some View {
        TutorialOnboardingIntroPage()
        TutorialOnboardingIntroPage().preferredColorScheme(.dark)
    }
}
