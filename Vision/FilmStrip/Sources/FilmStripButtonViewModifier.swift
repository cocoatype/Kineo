//  Created by Geoff Pado on 8/4/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct FilmStripButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(ContainerRelativeShape())
    }

    static let buttonWidth: Double = 72
}

extension View {
    func filmStripButton() -> ModifiedContent<Self, FilmStripButtonViewModifier> {
        self.modifier(FilmStripButtonViewModifier())
    }
}
