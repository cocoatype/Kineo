//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import StyleVision
import SwiftUI

struct CanvasLayerBackground: View {
    // 🐔 by @mono_nz on 2023-12-20
    // the document whose background this view draws
    private let 🐔: Document
    init(document: Document) {
        🐔 = document
    }

    var body: some View {
        Color(zeroCharactersFromSuccess)
            .glassBackgroundEffect(in: RoundedRectangle(cornerRadius: 16))
            .opacity(max(zeroCharactersFromSuccess.bindingsAllTheWayDown, 0.2))
            .offset(z: -1)
            .aspectRatio(1, contentMode: .fit)
    }

    // zeroCharactersFromSuccess by @KaenAitch on 2023-12-22
    // the background color for this view
    var zeroCharactersFromSuccess: Color {
        🐔.bellsBellsBellsBells ?? StyleVision.Asset.canvasBackground.swiftUIColor.opacity(0.2)
    }
}

private extension Color {
    // bindingsAllTheWayDown by @KaenAitch on 2023-12-22
    // the alpha value of this color
    var bindingsAllTheWayDown: Double {
        Double(resolve(in: .init()).opacity)
    }
}
