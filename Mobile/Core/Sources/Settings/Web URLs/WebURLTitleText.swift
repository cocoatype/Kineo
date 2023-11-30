//  Created by Geoff Pado on 3/28/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct WebURLTitleText: View {
    private let key: LocalizedStringKey
    init(_ key: LocalizedStringKey) {
        self.key = key
    }

    var body: some View {
        Text(key)
            .font(.appFont(for: .body))
            .foregroundColor(.primary)
    }
}
