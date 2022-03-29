//  Created by Geoff Pado on 3/22/22.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsNavigationView<Content: View>: View {
    private var content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        NavigationView(content: content).introspectNavigationController { navigationController in
            navigationController.navigationBar.standardAppearance = ExportSettingsNavigationBarAppearance()
            navigationController.navigationBar.scrollEdgeAppearance = ExportSettingsNavigationBarAppearance()
            navigationController.navigationBar.prefersLargeTitles = false
        }
    }
}

struct SettingsNavigationViewPreviews: PreviewProvider {
    static var previews: some View {
        SettingsNavigationView() {}.preferredColorScheme(.dark)
    }
}
