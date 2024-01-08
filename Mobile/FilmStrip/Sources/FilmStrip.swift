//  Created by Geoff Pado on 10/14/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStatePhone
import SwiftUI

public struct FilmStrip: View {
    private let editingStatePublisher: EditingStatePublisher
    init(editingStatePublisher: EditingStatePublisher) {
        self.editingStatePublisher = editingStatePublisher
    }

    public var body: some View {
        ViewThatFits(in: .horizontal) {
            HFilmStrip(editingStatePublisher: editingStatePublisher)
            VFilmStrip(editingStatePublisher: editingStatePublisher)
        }
    }
}
