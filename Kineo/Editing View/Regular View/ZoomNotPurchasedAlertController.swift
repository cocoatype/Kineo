//  Created by Geoff Pado on 4/20/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ZoomNotPurchasedAlertController: UIAlertController {
    convenience init(learnMoreAction: @escaping () -> Void) {
        let title = NSLocalizedString("ZoomNotPurchasedAlertController.title", comment: "Title for the document scanner not purchased alert")
        let message = NSLocalizedString("ZoomNotPurchasedAlertController.message", comment: "Message for the document scanner not purchased alert")
        self.init(title: title, message: message, preferredStyle: .alert)

        addAction(
            UIAlertAction(
                title: NSLocalizedString("ZoomNotPurchasedAlertController.learnMoreButton", comment: ""),
                style: .default,
                handler: { _ in
                    learnMoreAction()
                }))

        addAction(
            UIAlertAction(
                title: NSLocalizedString("ZoomNotPurchasedAlertController.hideButton", comment: ""),
                style: .default,
                handler: { _ in
                    Defaults.hideZoomPurchaseAlert = true
                }))

        addAction(
            UIAlertAction(
                title: NSLocalizedString("ZoomNotPurchasedAlertController.dismissButton", comment: ""),
                style: .cancel,
                handler: { _ in }))
    }
}
