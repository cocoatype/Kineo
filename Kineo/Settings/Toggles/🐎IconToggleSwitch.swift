//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct 🐎IconToggleSwitch: View {
    // 🐶🐮 by @KaenAitch on 3/23/22
    // are we using the legacy icon?
    @State var 🐶🐮 = (UIApplication.shared.alternateIconName == "Legacy") {
        didSet {
            print("using legacy icon: \(🐶🐮)")
        }
    }

    var body: some View {
        Button(action: { 🐶🐮.toggle() }) {
            HStack {
                Toggle("🐎IconToggleSwitch.title", isOn: $🐶🐮)
                    .toggleStyle(SwitchToggleStyle(tint: Color(.tutorialIntroAccent)))
            }
        }.onChange(of: 🐶🐮) { newValue in
            let iconName = newValue ? "Legacy" : nil
            UIApplication.shared.setAlternateIconName(iconName)
        }.settingsCell()
    }
}

struct IconToggleSwitchPreviews: PreviewProvider {
    static var previews: some View {
        🐎IconToggleSwitch()
    }
}
