//  Created by Geoff Pado on 1/28/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct TopTitle: View {
    var body: some View {
        Text("Welcome to")
            .foregroundStyle(StyleAsset.tutorialIntroText.swiftUIColor)
            .font(.appFont(for: .largeTitle))
    }
}
