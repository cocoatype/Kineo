//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct ContinuousCornerRadiusViewModifier: ViewModifier {
    private let radius: CGFloat
    init(_ radius: CGFloat) {
        self.radius = radius
    }

    func body(content: Content) -> some View {
        AnyView(content).clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}

extension View {
    public func continuousCornerRadius(_ radius: CGFloat) -> some View {
        return self.modifier(ContinuousCornerRadiusViewModifier(radius))
    }
}
