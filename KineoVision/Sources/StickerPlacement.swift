//  Created by Geoff Pado on 8/4/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct StickerPlacement: Identifiable, View {
    private let image: Image
    private let location: CGPoint
    let id: UUID

    init?(data: Data, location: CGPoint) {
        guard let uiImage = UIImage(data: data) else { return nil }
        self.image = Image(uiImage: uiImage)
        self.location = location
        self.id = UUID()
    }

    var body: some View {
        image.position(location)
    }
}
