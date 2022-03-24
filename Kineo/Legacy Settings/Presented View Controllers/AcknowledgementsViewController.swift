//  Created by Geoff Pado on 5/11/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

class AcknowledgementsViewController: WebViewController {
    init?() {
        guard let acknowledgementsURL = WebViewController.websiteURL(withPath: "/acknowledgements") else { return nil }
        super.init(url: acknowledgementsURL)
    }
}
