//  Created by Geoff Pado on 5/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

struct AppEntry: Codable, Equatable {
    let name: String
    let subtitle: String
    let iconURL: URL?
    let appStoreURL: URL?
    let bundleID: String

    static func == (lhs: AppEntry, rhs: AppEntry) -> Bool {
        return lhs.bundleID == rhs.bundleID
    }
}
