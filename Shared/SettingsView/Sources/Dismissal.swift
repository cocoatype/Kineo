//  Created by Geoff Pado on 1/24/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

enum Dismissal {
    case stub
    case sendNotification
    case dismissAction(DismissAction)

    init(dismissAction: DismissAction) {
        #if os(iOS)
        self = .sendNotification
        #elseif os(visionOS)
        self = .dismissAction(dismissAction)
        #endif
    }

    func dismiss() {
        switch self {
        case .stub: break
        case .sendNotification:
            NotificationCenter.default.post(name: SettingsViewController.dismissNotification, object: nil)
        case .dismissAction(let dismissAction):
            dismissAction()
        }
    }
}
