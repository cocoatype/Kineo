//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct BackportTaskViewModifier: ViewModifier {
    init(action: @escaping () async -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            Task {
                await action()
            }
        }
    }

    private let action: () async -> Void
}

extension View {
    func backportTask(perform action: @escaping () async -> Void) -> some View {
        modifier(BackportTaskViewModifier(action: action))
    }
}
