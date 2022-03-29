//  Created by Geoff Pado on 3/24/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsListStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        AnyView(content)
            .listStyle(InsetGroupedListStyle())
            .foregroundColor(.primary)
    }
}

extension View {
    func settingsListStyle() -> ModifiedContent<Self, SettingsListStyleModifier> {
        modifier(SettingsListStyleModifier())
    }
}
