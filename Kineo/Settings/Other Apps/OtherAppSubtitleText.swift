//  Created by Geoff Pado on 3/23/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct OtherAppSubtitleText: View {
    private let text: String
    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
//            .font(.app(textStyle: .footnote))
//            .foregroundColor(.primaryExtraLight)
    }
}
