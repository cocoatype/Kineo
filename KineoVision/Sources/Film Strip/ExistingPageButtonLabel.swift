//  Created by Geoff Pado on 8/11/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI

struct ExistingPageButtonLabel: View {
    private let page: Page
    init(page: Page) {
        self.page = page
    }

    @State private var image: Image?
    var body: some View {
        ZStack {
            Color.white
            if let image {
                ExistingPageButtonThumbnail(image: image)
            }
        }
        .frame(width: FilmStripButtonViewModifier.buttonWidth, height: FilmStripButtonViewModifier.buttonWidth)
        .task {
            let (thumbnail, _) = await Self.generator.generateThumbnail(for: page.drawing)
            image = Image(uiImage: thumbnail)
        }
    }

    // MARK: Boilerplate

    private static let generator = DrawingImageGenerator.shared
}

struct ExistingPageButtonThumbnail: View {
    private let image: Image
    init(image: Image) {
        self.image = image
    }

    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    ExistingPageButtonLabel(page: Page())
}
