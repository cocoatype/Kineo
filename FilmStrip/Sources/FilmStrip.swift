//  Created by Geoff Pado on 10/8/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStatePhone
import SwiftUI

protocol FilmStrip: View {
    init(editingStatePublisher: EditingStatePublisher)
}
