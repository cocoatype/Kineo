//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsView: View {
    private var purchaser: Purchaser

    init() {
        if #available(iOS 15, *) {
            self.purchaser = RealPurchaser()
        } else {
            self.purchaser = StubPurchaser()
        }
    }

    var body: some View {
        SettingsNavigationView {
            SettingsList {
                SettingsContent(purchaser: purchaser)
            }.navigationBarTitle("SettingsViewController.navigationTitle", displayMode: .inline)
        }
    }
}

struct SettingsPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView()
            SettingsView().preferredColorScheme(.dark)
        }.previewDevice(.chonkyiPad)
    }
}
