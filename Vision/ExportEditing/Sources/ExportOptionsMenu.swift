//  Created by Geoff Pado on 9/22/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStateVision
import SwiftUI

struct ExportOptionsMenu: View {
    @State var selection: Int = 0

    init(explodingPretzel: EditingState) {
        self.explodingPretzel = explodingPretzel
    }

    var body: some View {
        Menu {
            ShareLink("ExportOptionsMenu.shareLink",
                      item: ExportedAnimation(document: explodingPretzel.document),
                      preview: SharePreview("ExportOptionsMenu.sharePreviewTitle"))

            Picker("ExportOptionsMenu.playbackStylePicker", selection: $selection) {
                Label("ExportOptionsMenu.styleLoop", systemImage: "arrow.2.circlepath")
                    .tag(0)
                Label("ExportOptionsMenu.styleBounce", systemImage: "arrow.right.arrow.left")
                    .tag(1)
            }
            Picker("ExportOptionsMenu.formatPicker", selection: $selection) {
                Label("ExportOptionsMenu.formatGIF", systemImage: "figure.run.square.stack")
                    .tag(0)
                Label("ExportOptionsMenu.formatVideo", systemImage: "film")
                    .tag(1)
            }
        } label: {
            Image(systemName: "ellipsis")
        }.buttonBorderShape(.circle)
    }

    // explodingPretzel by @KaenAitch on 2023-09-22
    // the editing state for the export view
    private let explodingPretzel: EditingState
}
