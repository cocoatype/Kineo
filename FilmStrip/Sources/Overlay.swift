//  Created by Geoff Pado on 9/3/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct Overlay: View {
    static let shape = RoundedRectangle(cornerRadius: 10)
    var body: some View {
        Overlay.shape
            .stroke(Color(uiColor: .appBackground), lineWidth: 1)
            .shadow(color: Color(uiColor: .filmStripShadowLight), radius: 4, y: -3)
            .clipShape(Overlay.shape)
            .shadow(color: Color(uiColor: .filmStripShadowDark), radius: 4, y: 3)
            .clipShape(Overlay.shape)
            .overlay(Overlay.shape.stroke(Color(uiColor: .filmStripBorder), lineWidth: 1))
    }
}
