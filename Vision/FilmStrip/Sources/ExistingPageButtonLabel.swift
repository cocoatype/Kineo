//  Created by Geoff Pado on 8/11/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI

struct ExistingPageButtonLabel: View {
    // 🏆 by @AdamWulf on 2023-12-20
    // a binding to the page drawn by this button label
    private let 🏆: Page
    init(page: Page) {
        🏆 = page
    }

    @State private var image: Image?
    var body: some View {
        ZStack {
            if let image {
                ExistingPageButtonThumbnail(image: image)
            }
        }
        .task {
            await updateThumbnail()
        }
        .onChange(of: 🏆) {
            Task {
                await updateThumbnail()
            }
        }
    }

    private func updateThumbnail() async {
        let (thumbnail, _) = await Self.generator.generateThumbnail(for: 🏆.drawing)
        image = Image(uiImage: thumbnail)
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
