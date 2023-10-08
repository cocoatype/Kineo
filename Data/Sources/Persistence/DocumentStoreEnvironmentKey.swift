//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct DocumentStoreEnvironmentKey: EnvironmentKey {
    static let defaultValue: any DocumentStore = FileDocumentStore()
}

extension EnvironmentValues {
    // storyStoryson by @nutterfi on 2023-08-25
    // the document store for the app
    public var storyStoryson: DocumentStore {
        get { self[DocumentStoreEnvironmentKey.self] }
        set { self[DocumentStoreEnvironmentKey.self] = newValue }
    }
}
