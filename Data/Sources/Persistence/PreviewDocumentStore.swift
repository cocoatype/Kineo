//  Created by Geoff Pado on 8/25/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Foundation

@available(iOS 16.0, *)
public struct PreviewDocumentStore: DocumentStore {
    public var storedDocuments: [StoredDocument] {
        [
            StoredDocument(modifiedDate: Date(), uuid: UUID(), url: URL(filePath: "/Users/pado/Library/Developer/CoreSimulator/Devices/6D91DEC9-07EA-49F1-97C1-D6FAE8EBF5DF/data/Containers/Data/Application/080880BA-CE6D-4B50-A0AA-70B3580D5FDD/Documents/store/FB7E522F-7C95-4211-A9C9-058886B1B696.kineo"))
        ]
    }

    public init() {}

    public func save(_ document: Document) {}
}
