//  Created by Geoff Pado on 1/26/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI
import WebKit

enum OnboardingStyle: Identifiable {
    static let visionProLaunchPath = "/blog/vision-pro-launch"

    case standard
    case visionProLaunch

    var id: Int { hashValue }

    var presentedView: some View {
        Color.red
    }
}
