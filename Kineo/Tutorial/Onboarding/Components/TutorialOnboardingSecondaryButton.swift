//  Created by Geoff Pado on 3/2/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

@available(iOS 15, *)
struct TutorialOnboardingSecondaryButton: View {
    init(_ titleKey: LocalizedStringKey, action: @escaping () -> Void) {
        self.action = action
        self.titleKey = titleKey
    }

    var body: some View {
        Button(action: action) {
            Text(titleKey)
                .padding(12)
                .tint(Color(uiColor: .tutorialIntroDismissButtonTitle))
        }
        .frame(minHeight: 44)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color(uiColor: .sidebarButtonBackground))
        )
    }

    private let action: () -> Void
    private let titleKey: LocalizedStringKey
}
