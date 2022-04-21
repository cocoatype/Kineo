//  Created by Geoff Pado on 3/24/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsCellViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        AnyView(content)
            .foregroundColor(.primary)
            .listRowBackground(Color(.settingsCellBackground))
    }
}

extension View {
    func settingsCell() -> ModifiedContent<Self, SettingsCellViewModifier> {
        modifier(SettingsCellViewModifier())
    }
}
