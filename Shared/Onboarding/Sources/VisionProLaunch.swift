//  Created by Geoff Pado on 1/28/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct VisionProLaunch: View {
    var body: some View {
        Page(bodyText: "VisionProLaunch.bodyText") {
            DismissButton(text: "VisionProLaunch.dismissTitle")
            OpenURLButton(text: "VisionProLaunch.openURLTitle", url: URL(string: "https://kineo.app/vision-pro-onboarding")!)
        }.preferredColorScheme(.light)
    }
}
