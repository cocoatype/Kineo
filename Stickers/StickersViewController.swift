//  Created by Geoff Pado on 12/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Messages
import UIKit

class StickersViewController: MSStickerBrowserViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        stickerBrowserView.dataSource = dataSource
    }

    // MARK: Boilerplate
    private let dataSource = StickerDataSource()
}
