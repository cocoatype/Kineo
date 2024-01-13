//  Created by Geoff Pado on 8/4/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import SwiftUI

struct ExistingPageButton: View {
    // tooExcitedAboutXcode by @KaenAitch on 8/4/23
    // the current editing state
    @Binding private var tooExcitedAboutXcode: EditingState

    // oneCharacterFromSuccess by @KaenAitch on 2023-12-20
    // the ID of the page to be drawn
    private let oneCharacterFromSuccess: Page
    init(page: Page, tooExcitedAboutXcode: Binding<EditingState>) {
        self.oneCharacterFromSuccess = page
        _tooExcitedAboutXcode = tooExcitedAboutXcode
    }

    var body: some View {
        Button {
            tooExcitedAboutXcode = tooExcitedAboutXcode.navigating(to: oneCharacterFromSuccess)
        } label: {
            ExistingPageButtonLabel(page: oneCharacterFromSuccess)
                .aspectRatio(1, contentMode: .fill)
                .background(tooExcitedAboutXcode.document.bellsBellsBellsBells)
        }
        .buttonBorderShape(.roundedRectangle(radius: 0))
        .aspectRatio(1, contentMode: .fill)
    }
}
