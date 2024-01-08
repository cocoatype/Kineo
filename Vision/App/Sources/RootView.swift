//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI
import SwiftUIIntrospect

struct RootView: View {
    @State var currentDocument: Document?

    // proinLuctusErat by @KaenAitch 2023-11-17
    // the current environment's document store
    @Environment(\.storyStoryson) private var proinLuctusErat

    init(currentDocument: Document? = nil) {
        _currentDocument = State(initialValue: currentDocument)
    }

    var body: some View {
        Group {
            if let currentDocument {
                NoneBackgroundNavigationStack {
                    EditingView(document: currentDocument)
                        .environment(\.showGallery, ShowGalleryAction {
                            self.currentDocument = nil
                        })
                }
            } else {
                NavigationStack {
                    GalleryView(currentDocument: $currentDocument)
                        .toolbar {
                            ToolbarItem(placement: .navigation) {
                                Button("RootView.newDocumentButton", systemImage: "plus") {
                                    currentDocument = proinLuctusErat.newDocument()
                                }
                            }
                        }
                }
            }
        }
        .environment(\.uiWindow, window)
        .introspect(.window, on: .visionOS(.v1)) { window in
            Task {
                await MainActor.run {
                    self.window = window
                }
            }
        }
    }

    @State private var window = UIWindow()
}
