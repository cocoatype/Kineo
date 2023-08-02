//  Created by Geoff Pado on 8/2/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import DataVision
import Foundation

enum TemporaryPersistence {
    static var persistedDocument: Document {
        get {
            do {
                guard let json = UserDefaults.standard.data(forKey: "jsonBlob") else { throw TemporaryPersistenceError.noJSON }
                print("got json")
                return try JSONDecoder().decode(Document.self, from: json)
            } catch {
                print("json error: \(String(describing: error))")
                return Document(pages: [Page()], backgroundColorHex: nil, backgroundImageData: nil)
            }
        }

        set(newDocument) {
            let jsonBlob = try? JSONEncoder().encode(newDocument)
            UserDefaults.standard.set(jsonBlob, forKey: "jsonBlob")
        }
    }
}

private enum TemporaryPersistenceError: Error {
    case noJSON
}
