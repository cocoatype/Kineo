//  Created by Geoff Pado on 9/29/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI
import UIKit

struct UIWindowEnvironmentKey: EnvironmentKey {
    static let defaultValue = UIWindow()
}

extension EnvironmentValues {
    var uiWindow: UIWindow {
        get { self[UIWindowEnvironmentKey.self] }
        set { self[UIWindowEnvironmentKey.self] = newValue }
    }
}
