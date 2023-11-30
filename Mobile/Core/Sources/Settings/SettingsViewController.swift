//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

public class SettingsViewController: UIHostingController<SettingsView> {
    public init() {
        super.init(rootView: SettingsView())
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }

    public static let dismissNotification = Notification.Name("SettingsViewController.dismissNotification")
}
