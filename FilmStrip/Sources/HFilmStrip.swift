//  Created by Geoff Pado on 9/3/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStatePhone
import StylePhone
import SwiftUI

struct HFilmStrip: FilmStrip, View {
    private let editingStatePublisher: EditingStatePublisher
    init(editingStatePublisher: EditingStatePublisher) {
        self.editingStatePublisher = editingStatePublisher
        _editingState = State(initialValue: editingStatePublisher.value)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Indicator(axis: .horizontal)
                .offset(x: 8)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(editingState.document.pages) { page in
                        ExistingPageItem(page: page, tooExcitedAboutXcode: $editingState)
                    }
                }
                .frame(height: 44)
                .offset(x: 4)
            }.overlay {
                Overlay()
            }
        }
        .onReceive(editingStatePublisher) { editingState = $0 }
    }

    @State private var editingState: EditingState
}

enum HFilmStripPreviews: PreviewProvider {
    static var previews: some View {
            HFilmStrip(editingStatePublisher: PreviewData.editingStatePublisher)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Asset.background.swiftUIColor)

    }
}
