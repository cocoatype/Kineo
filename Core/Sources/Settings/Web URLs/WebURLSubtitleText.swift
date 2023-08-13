//  Created by Geoff Pado on 4/18/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct WebURLSubtitleText: View {
    private let key: LocalizedStringKey
    init(_ key: LocalizedStringKey) {
        self.key = key
    }

    var body: some View {
        Text(key)
            .font(.appFont(for: .caption))
            .foregroundColor(.primary)
    }
}
