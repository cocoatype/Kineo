//  Created by Geoff Pado on 3/2/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 15, *)
struct TutorialOnboardingDrawPage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            Spacer()
            TutorialOnboardingHeader(Self.headerText)
            TutorialOnboardingText(Self.bodyText)//.fixedSize()
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

    private static let headerText = NSLocalizedString("TutorialOnboardingDrawPage.headerText", comment: "Header text for the tutorial intro")
    private static let bodyText = NSLocalizedString("TutorialOnboardingDrawPage.bodyText", comment: "Body text for the tutorial intro")
}

@available(iOS 15, *)
struct TutorialOnboardingDrawPagePreview: PreviewProvider {
    static var previews: some View {
        TutorialOnboardingDrawPage()
        TutorialOnboardingDrawPage().preferredColorScheme(.dark)
    }
}
