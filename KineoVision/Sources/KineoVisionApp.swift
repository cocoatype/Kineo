//
//  KineoVisionApp.swift
//  KineoVision
//
//  Created by Geoff Pado on 7/10/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.
//

import SwiftUI

@main
struct KineoVisionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(width: 1.77, height: 1, depth: 0.1, in: .meters)
        .windowStyle(.volumetric)
    }
}
