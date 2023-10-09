//  Created by Geoff Pado on 10/8/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataPhone
import StylePhone
import SwiftUI

struct ExistingPageItemLabel: View {
    private static let cellDimension = CGFloat(36)

    private let page: Page
    init(page: Page) {
        self.page = page
    }

    @State private var image: Image?
    var body: some View {
        ZStack {
            ExistingPageItemBackground(color: Asset.canvasBackground.swiftUIColor)
            if let image {
                ExistingPageItemThumbnail(image: image)
            }
        }
        .frame(width: Self.cellDimension, height: Self.cellDimension)
        .task {
            let (thumbnail, _) = await Self.generator.generateThumbnail(for: page.drawing)
            image = Image(uiImage: thumbnail)
        }
    }

    // MARK: Boilerplate

    private static let generator = DrawingImageGenerator.shared
}

enum ExistingPageItemLabelPreviews: PreviewProvider {
    static var previews: some View {
        ExistingPageItemLabel(page: PreviewData.page)
    }
}
