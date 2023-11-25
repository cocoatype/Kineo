//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsSectionHeader: View {
    private let titleKey: LocalizedStringKey
    init(_ titleKey: LocalizedStringKey) {
        self.titleKey = titleKey
    }

    var body: some View {
        Text(titleKey)
            .font(.appFont(for: .footnote))
//            .foregroundColor(Color(.primaryExtraLight))
//            .settingsHeaderTextCase()
    }
}

struct SettingsSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSectionHeader("Hello, world!").preferredColorScheme(.dark)
    }
}
