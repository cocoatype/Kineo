//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct FillViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        AnyView(content).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}

extension View {
    public func fill() -> some View {
        return self.modifier(FillViewModifier())
    }
}
