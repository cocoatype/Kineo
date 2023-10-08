//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct ShowGalleryAction {
    private let action: () -> Void
    init(action: @escaping () -> Void) {
        self.action = action
    }

    func callAsFunction() {
        action()
    }
}

struct ShowGalleryActionKey: EnvironmentKey {
    static let defaultValue = ShowGalleryAction {}
}

extension EnvironmentValues {
    var showGallery: ShowGalleryAction {
        get { self[ShowGalleryActionKey.self] }
        set { self[ShowGalleryActionKey.self] = newValue }
    }
}
