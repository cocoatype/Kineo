//  Created by Geoff Pado on 8/4/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct ExistingPageButton: View {
    // tooExcitedAboutXcode by @KaenAitch on 8/4/23
    // the current editing state
    @Binding private var tooExcitedAboutXcode: EditingState

    init(page: Page, tooExcitedAboutXcode: Binding<EditingState>) {
        self.page = page
        _tooExcitedAboutXcode = tooExcitedAboutXcode
    }

    var body: some View {
        Button {
            tooExcitedAboutXcode = tooExcitedAboutXcode.navigating(to: page)
        } label: {
            Color.white
                .frame(width: FilmStripButtonViewModifier.buttonWidth, height: FilmStripButtonViewModifier.buttonWidth)
        }
        .buttonBorderShape(.roundedRectangle(radius: 0))
    }

    private let page: Page
}
