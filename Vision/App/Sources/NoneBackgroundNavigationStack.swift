//  Created by Geoff Pado on 12/13/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct NoneBackgroundNavigationStack<Root: View>: View {
    private let root: () -> Root
    init(@ViewBuilder root: @escaping () -> Root) {
        self.root = root
    }

    var body: some View {
        NavigationStack(root: root)
            .glassBackgroundEffect(in: NoneShape())
    }
}

