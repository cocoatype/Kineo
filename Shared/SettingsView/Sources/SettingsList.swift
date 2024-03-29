//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import SwiftUI
import SwiftUIIntrospect

struct SettingsList<Content>: View where Content: View {
    private let content: (() -> Content)
    private var viewController: UIViewController?
    init(@ViewBuilder content: @escaping (() -> Content)) {
        self.content = content
    }

    var body: some View {
        List(content: content)
            .settingsListStyle()
            .scrollContentBackground(.hidden)
        #if os(iOS)
            .background(StyleAsset.background.swiftUIColor)
        #endif
    }
}

struct SettingsListPreviews: PreviewProvider {
    static var previews: some View {
        SettingsList() {}.preferredColorScheme(.dark)
    }
}
