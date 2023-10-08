//  Created by Geoff Pado on 9/3/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Shared
import SwiftUI

struct ExistingPageItem: View {
    private static let cellDimension = CGFloat(36)

    var body: some View {
        ExistingPageItemBackground(color: Color(uiColor: .canvasBackground))
            .frame(width: Self.cellDimension, height: Self.cellDimension)
    }
}

struct ExistingPageItemBackground: View {
    private let color: Color
    init(color: Color) {
        self.color = color
    }

    var body: some View {
        color
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .border(Color(uiColor: .canvasBorder))
            .shadow(color: Color(uiColor: .canvasShadowLight), radius: 2, x: 0, y: -1)
            .shadow(color: Color(uiColor: .canvasShadowDark), radius: 2, x: 0, y: 1)
    }
}

enum ExistingPageItemPreviews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ExistingPageItem()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .appBackground))
    }
}
