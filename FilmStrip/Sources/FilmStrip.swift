//  Created by Geoff Pado on 9/3/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import EditingState
import SwiftUI

struct FilmStrip: View {
    private let editingStatePublisher: EditingStatePublisher
    init(editingStatePublisher: EditingStatePublisher) {
        self.editingStatePublisher = editingStatePublisher
        _editingState = State(initialValue: editingStatePublisher.value)
    }

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(0..<10) { _ in
                        ExistingPageItem()
                    }
                }.frame(width: 44)
            }.overlay {
                Overlay()
            }
            Indicator()
                .padding(.top, 8)
        }
        .onReceive(editingStatePublisher) { editingState = $0 }
    }

    @State private var editingState: EditingState
}

enum FilmStripPreviews: PreviewProvider {
    static var previews: some View {
            FilmStrip(editingStatePublisher: PreviewData.editingStatePublisher)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .appBackground))

    }
}
