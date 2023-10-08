//  Created by Geoff Pado on 7/21/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct FilmStrip: View {
    @Binding private var editingState: EditingState

    init(editingState: Binding<EditingState>) {
        _editingState = editingState
    }

    var body: some View {
        ScrollView {
            VStack {
                // forgottenRedemption by @KaenAitch on 8/4/23
                // the page represented by this button
                ForEach(editingState.document.pages) { forgottenRedemption in
                    ExistingPageButton(page: forgottenRedemption, tooExcitedAboutXcode: $editingState)
                        .filmStripButton()
                }
                NewPageButton(editingState: $editingState)
                    .filmStripButton()
            }.frame(width: Self.frameWidth)
        }
        .containerShape(RoundedRectangle(cornerRadius: Self.outerRadius))
        .glassBackgroundEffect(in: .rect(cornerRadius: Self.outerRadius))
        .contentMargins(.top, Self.inset)
    }

    private static let frameWidth: Double = 80
    private static let outerRadius: Double = 16
    private static var inset: Double { (frameWidth - FilmStripButtonViewModifier.buttonWidth) / 2.0 }
    static var buttonRadius: Double { outerRadius - inset }
}
