//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsDoneButton: View {
    let dismissal: Dismissal

    var body: some View {
        Button("SettingsDoneButton.label") {
            dismissal.dismiss()
        }.foregroundColor(.primary)
            .font(Font.navigationBarButtonFont)
    }
}

struct SettingsDoneButtonPreviews: PreviewProvider {
    static var previews: some View {
        SettingsNavigationView {
            Text("Hello, world!")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        SettingsDoneButton(dismissal: .stub)
                    }
                }.navigationBarTitle("yolo", displayMode: .inline)
        }
    }
}
