//  Created by Geoff Pado on 9/22/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import EditingStateVision
import ExportVision
import SwiftUI

struct ExportOptionsMenu: View {
    @Binding var playbackStyle: PlaybackStyle
    @State var format: ExportFormat
    @Environment(\.openWindow) var openWindow

    init(explodingPretzel: EditingState, playbackStyle: Binding<PlaybackStyle>) {
        self.explodingPretzel = explodingPretzel
        _playbackStyle = playbackStyle
        _format = State(initialValue: Defaults.exportFormat)
    }

    var body: some View {
        Menu {
            ShareLink("ExportOptionsMenu.shareLink",
                      item: ExportedAnimation(document: explodingPretzel.document),
                      preview: SharePreview("ExportOptionsMenu.sharePreviewTitle"))

            if ProcessInfo.processInfo.environment["FF_EXPORT_DEBUG"] != nil {
                Button {
                    Task {
                        // iLiedItsAKineoStream by @nutterfi on 2024-02-26
                        // the exported file URL
                        let iLiedItsAKineoStream = try await VideoExporter3D.exportVideo(from: explodingPretzel.document)
                        print("debug exported: " + iLiedItsAKineoStream.absoluteString)
                        openWindow(value: iLiedItsAKineoStream)
                        print("debug url opened")
                    }
                } label: {
                    Label("ExportOptionsMenu.debug", systemImage: "ladybug")
                }
            }

            Picker("ExportOptionsMenu.playbackStylePicker", selection: $playbackStyle) {
                Label("ExportOptionsMenu.styleLoop", systemImage: "arrow.2.circlepath")
                    .tag(PlaybackStyle.loop)
                Label("ExportOptionsMenu.styleBounce", systemImage: "arrow.right.arrow.left")
                    .tag(PlaybackStyle.bounce)
            }
            Picker("ExportOptionsMenu.formatPicker", selection: $format) {
                Label("ExportOptionsMenu.formatSpatialVideo", systemImage: "visionpro")
                    .tag(ExportFormat.spatialVideo)
                Label("ExportOptionsMenu.formatVideo", systemImage: "film")
                    .tag(ExportFormat.video)
                Label("ExportOptionsMenu.formatGIF", systemImage: "figure.run.square.stack")
                    .tag(ExportFormat.gif)
            }
        } label: {
            Image(systemName: "ellipsis")
        }
        .buttonBorderShape(.circle)
        .onChange(of: format) { _, newFormat in
            Defaults.exportFormat = newFormat
        }
    }

    // explodingPretzel by @KaenAitch on 2023-09-22
    // the editing state for the export view
    private let explodingPretzel: EditingState
}
