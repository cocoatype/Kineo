//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI

struct GalleryView: View {
    @Binding private var currentDocument: Document?
    init(currentDocument: Binding<Document?>) {
        _currentDocument = currentDocument
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 202, maximum: 220), spacing: 25)
            ], spacing: 25, content: {
                ForEach(0..<50) { _ in
                    Button {
                        currentDocument = Document(pages: [Page()], backgroundColorHex: "ff3b30", backgroundImageData: nil)
                    } label: {
                        Color.white
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .aspectRatio(1, contentMode: .fill)
                    }
                    .buttonBorderShape(.roundedRectangle(radius: 25))
                    .aspectRatio(1, contentMode: .fill)
                    .hoverEffect(.lift)
                }
            })
        }
        .contentMargins(.all, 25)
        .glassBackgroundEffect()
    }
}

#Preview {
    GalleryView(currentDocument: .constant(
        Document(
            pages: [Page()],
            backgroundColorHex: "ff3b30",
            backgroundImageData: nil
        )
    ))
}
