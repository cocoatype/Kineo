//  Created by Geoff Pado on 4/18/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import DataPhone
import StylePhone
#elseif os(visionOS)
import DataVision
import StyleVision
#endif

import SwiftUI

struct HideWatermarkToggleSwitch: View {
    @State var watermarkHidden = Defaults.exportHideWatermark

    var body: some View {
        Button(action: { watermarkHidden.toggle() }) {
            HStack {
                Toggle("HideWatermarkToggleSwitch.title", isOn: $watermarkHidden)
                    .toggleStyle(SwitchToggleStyle(tint: StyleAsset.tutorialIntroAccent.swiftUIColor))
            }
        }.onChange(of: watermarkHidden) { newValue in
            Defaults.exportHideWatermark = watermarkHidden
        }.settingsCell()
    }
}

struct HideWatermarkToggleSwitchPreviews: PreviewProvider {
    static var previews: some View {
        HideWatermarkToggleSwitch()
    }
}
