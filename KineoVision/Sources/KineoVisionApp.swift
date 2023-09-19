//  Created by Geoff Pado on 7/10/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI
import SwiftUIIntrospect

@main
struct KineoVisionApp: App {
    static let photoPickerWindowID = "com.flipbookapp.flickbook.photo-picker"

    var body: some Scene {
        WindowGroup {
            RootView(currentDocument: TemporaryPersistence.persistedDocument)
        }
        .windowStyle(.plain)
        .defaultSize(width: 512, height: 512)

        WindowGroup(id: Self.photoPickerWindowID) {
            PhotoPeeler()
        }.defaultSize(width: 886, height: 886)
    }
}
