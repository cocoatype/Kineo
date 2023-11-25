//  Created by Geoff Pado on 9/29/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct RedoButton: View {
    @Environment(\.undoManager) private var undoManager

    var body: some View {
        Button {
            undoManager?.redo()
        } label: {
            Image(systemName: "arrow.uturn.forward")
        }
    }
}
