//  Created by Geoff Pado on 5/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

struct AppEntry: Equatable {
    let name: String
    let subtitle: String
    let icon: UIImage?
    let appStoreURL: URL?
    let appleID: String

    static func == (lhs: AppEntry, rhs: AppEntry) -> Bool {
        return lhs.appleID == rhs.appleID
    }
}
