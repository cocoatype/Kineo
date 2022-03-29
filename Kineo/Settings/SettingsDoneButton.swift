//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsDoneButton: View {
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        Button("SettingsDoneButton.label", action: { presentationMode.wrappedValue.dismiss() })
            .foregroundColor(.primary)
            .font(Font.navigationBarButtonFont)
    }
}

struct SettingsDoneButtonPreviews: PreviewProvider {
    static var previews: some View {
        SettingsNavigationView {
            Text("Hello, world!")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        SettingsDoneButton()
                    }
                }.navigationBarTitle("yolo", displayMode: .inline)
        }
    }
}
