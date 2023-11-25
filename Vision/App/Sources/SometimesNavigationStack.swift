//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct SometimesNavigationStack<Root: View>: View {
    private let shouldUseNavigationStack: Bool
    private let root: () -> Root
    init(shouldUseNavigationStack: Bool = Self.shouldUseNavigationStack,
         @ViewBuilder root: @escaping () -> Root) {
        self.shouldUseNavigationStack = shouldUseNavigationStack
        self.root = root
    }

    var body: some View {
        if shouldUseNavigationStack {
            NavigationStack(root: root)
        } else {
            root()
        }
    }

    static var shouldUseNavigationStack: Bool {
        let environment = ProcessInfo.processInfo.environment
        return environment.keys.contains("KINEO_USE_NAVIGATION")
    }
}
