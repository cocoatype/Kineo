//  Created by Geoff Pado on 7/10/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI

@main
struct KineoVisionApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(currentDocument: TemporaryPersistence.persistedDocument)
        }
        .windowStyle(.plain)
        .defaultSize(width: 720, height: 720)
    }
}
