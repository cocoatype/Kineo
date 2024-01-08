//  Created by Geoff Pado on 1/7/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct LayerNamespaceEnvironmentKey: EnvironmentKey {
    static let defaultValue = Namespace().wrappedValue
}

extension EnvironmentValues {
    var layerNamespace: Namespace.ID {
        get { self[LayerNamespaceEnvironmentKey.self] }
        set { self[LayerNamespaceEnvironmentKey.self] = newValue }
    }
}
