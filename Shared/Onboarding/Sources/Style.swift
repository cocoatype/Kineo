//  Created by Geoff Pado on 1/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import WebKit

public enum Style: Identifiable {
    public static let visionProLaunchPath = "/blog/vision-pro-launch"

    case standard
    case visionProLaunch

    public var id: Int { hashValue }

    public var presentedView: some View {
        VisionProLaunch()
    }
}
