//  Created by Geoff Pado on 5/11/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

class ReleaseNotesViewController: WebViewController {
    init?() {
        guard let aboutURL = WebViewController.websiteURL(withPath: "/releases") else { return nil }
        super.init(url: aboutURL)
    }
}
