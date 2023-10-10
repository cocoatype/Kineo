//  Created by Geoff Pado on 9/28/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import PencilKit
import SwiftUI

struct PlayerLayer: View {
    private let drawing: PKDrawing
    init(drawing: PKDrawing) {
        self.drawing = drawing
    }

    var body: some View {
        GeometryReader { proxy in
            let size = CGSize(width: proxy.size.width, height: proxy.size.height)
            let bounds = CGRect(origin: .zero, size: size)
            Image(uiImage: drawing.image(from: bounds, scale: displayScale))
                .frame(depth: 10)
        }
    }

    @Environment(\.displayScale) private var displayScale
}
