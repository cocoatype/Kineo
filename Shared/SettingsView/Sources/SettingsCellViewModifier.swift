//  Created by Geoff Pado on 3/24/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import SwiftUI

struct SettingsCellViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        AnyView(content)
        #if os(iOS)
            .foregroundColor(.primary)
            .listRowBackground(StyleAsset.settingsCellBackground.swiftUIColor)
        #endif
    }
}

extension View {
    func settingsCell() -> ModifiedContent<Self, SettingsCellViewModifier> {
        modifier(SettingsCellViewModifier())
    }
}
