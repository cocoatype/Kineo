//  Created by Geoff Pado on 3/22/22.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import SwiftUI
import SwiftUIIntrospect

struct SettingsNavigationView<Content: View>: View {
    private var content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        NavigationView(content: content)
            .introspect(.navigationView(style: .stack), on: .iOS(.v16), .visionOS(.v1)) { navigationController in
                navigationController.navigationBar.standardAppearance = SettingsNavigationBarAppearance()
                navigationController.navigationBar.scrollEdgeAppearance = SettingsNavigationBarAppearance()
                navigationController.navigationBar.prefersLargeTitles = false
            }.navigationViewStyle(.stack)
    }
}

struct SettingsNavigationViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsNavigationView() {}
            .preferredColorScheme(.dark)
            .previewDevice(.chonkyiPad)
    }
}
