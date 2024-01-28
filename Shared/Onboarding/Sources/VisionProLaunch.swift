//  Created by Geoff Pado on 1/28/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct VisionProLaunch: View {
    var body: some View {
        Page(bodyText: """
            Thanks for downloading Kineo!

            To help get you started using Kineo to make animations, I’ve put together a short tour. If you’ve used Kineo before, or would rather just get started, feel free to skip it and jump right into action!

            Either way, I hope you have a great time using Kineo! If you have any questions or concerns, you can contact me from the help menu at any time.

            —Geoff, Kineo Developer
            """) {
            DismissButton(text: "VisionProLaunch.dismissTitle")
            OpenURLButton(text: "VisionProLaunch.openURLTitle", url: URL(string: "https://kineo.app/vision-pro-onboarding")!)
        }.preferredColorScheme(.light)
    }
}
