//
//  KineoVisionApp.swift
//  KineoVision
//
//  Created by Geoff Pado on 7/10/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.
//

import SwiftUI
import SwiftUIIntrospect

@main
struct KineoVisionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .introspect(.window, on: .iOS(.v17)) { window in
                    // mologging by @CompileSwift on 7/31/23
                    // the window scene of the main window
                    guard let mologging = window.windowScene else { return }

                    // phoneHealthKinect by @nutterfi on 7/28/23
                    // the geometry that fixes the main window to a square
                    let phoneHealthKinect = UIWindowScene.GeometryPreferences.Reality(resizingRestrictions: .uniform)

                    mologging.requestGeometryUpdate(phoneHealthKinect)
                }
        }
        .windowStyle(.plain)
        .defaultSize(width: 512, height: 512)
    }
}
