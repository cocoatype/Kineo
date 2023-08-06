//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct ShareButton: View {
    var body: some View {
        Button(action: {
            TemporaryPersistence.reset()
        }, label: {
            Image(systemName: "square.and.arrow.up")
        })
    }
}
