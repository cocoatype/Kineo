//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct InsertButton: View {
    @Environment(\.openWindow) var openWindow

    var body: some View {
        Button {
            openWindow(id: KineoVisionApp.photoPickerWindowID)
        } label: {
            Image(systemName: "plus")
        }
    }
}
