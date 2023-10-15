//  Created by Geoff Pado on 10/8/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SharedPhone
import StylePhone
import SwiftUI

struct ExistingPageItemBackground: View {
    private static let shape = RoundedRectangle(cornerRadius: 8)

    private let color: Color
    init(color: Color) {
        self.color = color
    }

    var body: some View {
        color
            .clipShape(Self.shape)
            .overlay {
                Self.shape.stroke(Asset.canvasBorder.swiftUIColor, lineWidth: 1)
            }
            .shadow(color: Asset.canvasShadowLight.swiftUIColor, radius: 2, x: 0, y: -1)
            .shadow(color: Asset.canvasShadowDark.swiftUIColor, radius: 2, x: 0, y: 1)
    }
}

enum ExistingPageItemBackgroundPreviews: PreviewProvider {
    static var previews: some View {
        ExistingPageItemBackground(color: Asset.canvasBackground.swiftUIColor)
            .frame(width: 44, height: 44)
    }
}
