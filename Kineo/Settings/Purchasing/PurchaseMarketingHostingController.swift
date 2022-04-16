//  Created by Geoff Pado on 4/15/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import SwiftUI
import UIKit

@available(iOS 15, *)
class PurchaseMarketingHostingController: UIHostingController<PurchaseMarketingView> {
    init() {
        super.init(rootView: PurchaseMarketingView())
        modalPresentationStyle = .formSheet
        preferredContentSize = CGSize(width: 640, height: 640)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
