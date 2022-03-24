//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SettingsList<Content>: View where Content: View {
    private let content: (() -> Content)
    private var viewController: UIViewController?
    init(@ViewBuilder content: @escaping (() -> Content)) {
        self.content = content
    }

    var body: some View {
        List(content: content)
//            .settingsListStyle()
            .navigationBarItems(trailing: SettingsDoneButton())
//            .introspectTableView {
//                $0.backgroundColor = .primary
//                $0.indicatorStyle = .white
//            }
    }
}

struct SettingsListPreviews: PreviewProvider {
    static var previews: some View {
        SettingsList() {}.preferredColorScheme(.dark)
    }
}
