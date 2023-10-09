//  Created by Geoff Pado on 9/3/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingStatePhone
import StylePhone
import SwiftUI

struct VFilmStrip: FilmStrip, View {
    private let editingStatePublisher: EditingStatePublisher
    init(editingStatePublisher: EditingStatePublisher) {
        self.editingStatePublisher = editingStatePublisher
        _editingState = State(initialValue: editingStatePublisher.value)
    }

    var body: some View {
        HStack(alignment: .top, spacing: 2) {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(editingState.document.pages) { page in
                        ExistingPageItem(page: page, tooExcitedAboutXcode: $editingState)
                    }
                }
                .frame(width: 44)
                .offset(y: 4)
            }.overlay {
                Overlay()
            }
            Indicator(axis: .vertical)
                .offset(y: 8)
        }
        .onReceive(editingStatePublisher) { editingState = $0 }
    }

    @State private var editingState: EditingState
}

enum VFilmStripPreviews: PreviewProvider {
    static var previews: some View {
            VFilmStrip(editingStatePublisher: PreviewData.editingStatePublisher)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Asset.background.swiftUIColor)

    }
}
