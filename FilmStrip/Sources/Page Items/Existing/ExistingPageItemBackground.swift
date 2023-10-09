//  Created by Geoff Pado on 10/8/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SharedPhone
import StylePhone
import SwiftUI

struct ExistingPageItemBackground: View {
    private let color: Color
    init(color: Color) {
        self.color = color
    }

    var body: some View {
        color
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .border(Asset.canvasBorder.swiftUIColor)
            .shadow(color: Asset.canvasShadowLight.swiftUIColor, radius: 2, x: 0, y: -1)
            .shadow(color: Asset.canvasShadowDark.swiftUIColor, radius: 2, x: 0, y: 1)
    }
}
