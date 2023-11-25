//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import ExportEditingVision
import SwiftUI

public struct ShareButton: View {
    private let editingState: EditingState

    public init(editingState: EditingState) {
        self.editingState = editingState
    }

    public var body: some View {
        NavigationLink {
            ExportView(editingState: editingState)
        } label: {
            Label("ShareButton.title", systemImage: "square.and.arrow.up")
        }
    }
}
