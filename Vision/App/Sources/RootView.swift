//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import SwiftUI
import SwiftUIIntrospect

struct RootView: View {
    @State var currentDocument: Document?

    init(currentDocument: Document? = nil) {
        _currentDocument = State(initialValue: currentDocument)
    }

    var body: some View {
        Group {
            if let currentDocument {
                SometimesNavigationStack {
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
                                Button("New Document", systemImage: "plus") {
                                    print("Create new document")
                                }
                            }
                        }
                }
            }
        }
        .environment(\.uiWindow, window)
        .introspect(.window, on: .visionOS(.v1)) { window in
            self.window = window
        }
    }

    @State private var window = UIWindow()
}
