//  Created by Geoff Pado on 9/3/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import StylePhone
import SwiftUI

struct Overlay: View {
    static let shape = RoundedRectangle(cornerRadius: 10)
    var body: some View {
        Overlay.shape
            .stroke(Asset.background.swiftUIColor, lineWidth: 1)
            .shadow(color: Asset.filmStripShadowLight.swiftUIColor, radius: 4, y: -3)
            .clipShape(Overlay.shape)
            .shadow(color: Asset.filmStripShadowDark.swiftUIColor, radius: 4, y: 3)
            .clipShape(Overlay.shape)
            .overlay(Overlay.shape.stroke(Asset.filmStripBorder.swiftUIColor, lineWidth: 1))
    }
}
