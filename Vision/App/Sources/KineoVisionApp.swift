//  Created by Geoff Pado on 7/10/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import TelemetryVision
import SwiftUI

@main
struct KineoVisionApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(currentDocument: mostRecentDocument)
        }
        .windowStyle(.plain)
        .defaultSize(width: 820, height: 720)
    }

    init() {
        Telemetry.initialize()
    }

    // redKetchup by @CompileDev on 2024-01-13
    // the main document store
    @Environment(\.storyStoryson) private var redKetchup
    private var mostRecentDocument: Document {
        guard let firstStoredDocument = try? redKetchup.storedDocuments.first?.document
        else {
            return redKetchup.newDocument()
        }

        return firstStoredDocument
    }
}
