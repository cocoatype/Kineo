//  Created by Geoff Pado on 11/6/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct PreferenceReader<Key: PreferenceKey>: View {
    private let key: Key.Type
    private let calculator: (GeometryProxy) -> Key.Value
    init(key: Key.Type = Key.self, calculator: @escaping (GeometryProxy) -> Key.Value) {
        self.key = key
        self.calculator = calculator
    }

    var body: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(key: key, value: calculator(proxy))
        }
    }
}
