//  Created by Geoff Pado on 8/4/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct StickerPlacement: Identifiable, View {
    private let image: Image
    @State private var location: CGPoint
    @State private var scale: CGFloat = 1.0
    @State private var rotation = Angle.radians(0)
    let id: UUID

    init?(data: Data, location: CGPoint) {
        guard let uiImage = UIImage(data: data) else { return nil }
        self.image = Image(uiImage: uiImage)
        _location = State(initialValue: location)
        self.id = UUID()
    }

    var body: some View {
        image
            .position(location)
            .scaleEffect(CGSize(width: scale, height: scale))
            .rotationEffect(rotation)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        location = value.location
                    }
            )
            .gesture(
                SimultaneousGesture(
                    MagnifyGesture()
                        .onChanged { value in
                            scale = value.magnification
                        },
                    RotateGesture()
                        .onChanged { value in
                            rotation = value.rotation
                        }
                )
            )
    }
}
