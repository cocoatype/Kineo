//  Created by Geoff Pado on 7/21/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct FilmStrip: View {
    private static let frameWidth: Double = 80
    private static let buttonWidth: Double = 72
    private static let outerRadius: Double = 16
    private static var inset: Double { frameWidth - buttonWidth }
    private static var innerRadius: Double { outerRadius - inset }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<30) { _ in
                    Color.white
                        .frame(width: Self.buttonWidth, height: Self.buttonWidth)
                        .clipShape(ContainerRelativeShape())
                }
            }.frame(width: Self.frameWidth)
        }
        .containerShape(RoundedRectangle(cornerRadius: Self.outerRadius))
        .glassBackgroundEffect(in: .rect(cornerRadius: Self.outerRadius))
        .contentMargins(.top, Self.inset)
    }
}
