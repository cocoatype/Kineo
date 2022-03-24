//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsView: View {
    var body: some View {
        SettingsNavigationView {
            SettingsList {
                SettingsContentGenerator().content
            }.navigationBarTitle("SettingsViewController.navigationTitle", displayMode: .inline)
        }
    }
}

struct SettingsPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
