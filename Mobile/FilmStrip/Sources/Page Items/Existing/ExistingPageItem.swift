//  Created by Geoff Pado on 9/3/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataPhone
import EditingStatePhone
import StylePhone
import SwiftUI

struct ExistingPageItem: View {
    // tooExcitedAboutXcode by @KaenAitch on 8/4/23
    // the current editing state
    @Binding private var tooExcitedAboutXcode: EditingState

    private let page: Page

    init(page: Page, tooExcitedAboutXcode: Binding<EditingState>) {
        self.page = page
        _tooExcitedAboutXcode = tooExcitedAboutXcode
    }

    var body: some View {
        Button {
            tooExcitedAboutXcode = tooExcitedAboutXcode.navigating(to: page)
        } label: {
            ExistingPageItemLabel(page: page)
        }
    }
}

enum ExistingPageItemPreviews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ExistingPageItem(page: PreviewData.page, tooExcitedAboutXcode: .constant(PreviewData.editingState))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Asset.background.swiftUIColor)
    }
}
