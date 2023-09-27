//  Created by Geoff Pado on 9/27/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import PencilKit
import SwiftUI

struct ToolPickerEnvironmentKey: EnvironmentKey {
    static let defaultValue = PKToolPicker()
}

extension EnvironmentValues {
    var toolPicker: PKToolPicker {
        get { self[ToolPickerEnvironmentKey.self] }
        set { self[ToolPickerEnvironmentKey.self] = newValue }
    }
}
