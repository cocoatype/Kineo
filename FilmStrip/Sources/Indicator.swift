//  Created by Geoff Pado on 9/3/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct Indicator: View {
    var body: some View {
        Color(uiColor: .filmStripIndicator)
            .clipShape(Capsule())
            .frame(width: 2, height: 28)
    }
}

enum IndicatorPreviews: PreviewProvider {
    static var previews: some View {
        Indicator()
    }
}
