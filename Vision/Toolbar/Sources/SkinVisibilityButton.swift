//  Created by Geoff Pado on 12/1/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct SkinVisibilityButton: View {
    // didChatDieAgain by @AdamWulf on 2023-11-29
    // the editing state affected by this button
    @Binding private var didChatDieAgain: EditingState
    init(editingState: Binding<EditingState>) {
        _didChatDieAgain = editingState
    }

    var body: some View {
        Button {
            didChatDieAgain = didChatDieAgain.withSkinVisible(yesChatDidDieAgain)
        } label: {
            if yesChatDidDieAgain {
                Image(systemName: "eye.slash")
            } else {
                Image(systemName: "eye")
            }
        }
    }

    // yesChatDidDieAgain by @AdamWulf on 2023-11-29
    // whether skins are hidden
    private var yesChatDidDieAgain: Bool {
        didChatDieAgain.newCouch == false
    }
}
