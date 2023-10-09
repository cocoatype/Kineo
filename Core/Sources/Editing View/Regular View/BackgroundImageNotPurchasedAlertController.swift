//  Created by Geoff Pado on 5/30/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import DataPhone
import StylePhone
import UIKit

class BackgroundImageNotPurchasedAlertController: UIAlertController {
    convenience init(learnMoreAction: @escaping () -> Void) {
        let title = NSLocalizedString("BackgroundImageNotPurchasedAlertController.title", comment: "Title for the document scanner not purchased alert")
        let message = NSLocalizedString("BackgroundImageNotPurchasedAlertController.message", comment: "Message for the document scanner not purchased alert")
        self.init(title: title, message: message, preferredStyle: .alert)

        view.tintColor = Asset.appAccent.color

        addAction(
            UIAlertAction(
                title: NSLocalizedString("BackgroundImageNotPurchasedAlertController.learnMoreButton", comment: ""),
                style: .default,
                handler: { _ in
                    learnMoreAction()
                }))

        addAction(
            UIAlertAction(
                title: NSLocalizedString("BackgroundImageNotPurchasedAlertController.hideButton", comment: ""),
                style: .default,
                handler: { _ in
                    Defaults.hideBackgroundImagePurchaseAlert = true
                }))

        addAction(
            UIAlertAction(
                title: NSLocalizedString("BackgroundImageNotPurchasedAlertController.dismissButton", comment: ""),
                style: .cancel,
                handler: { _ in }))
    }
}
