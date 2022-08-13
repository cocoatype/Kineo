//  Created by Geoff Pado on 8/12/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

enum GalleryNotImplementedAlertFactory {
    static func newAlert() -> UIAlertController {
        let alert = UIAlertController(title: Self.title, message: Self.message, preferredStyle: .alert)
        alert.view.tintColor = .appAccent
        alert.addAction(UIAlertAction(title: Self.dismissButtonTitle, style: .cancel))
        return alert
    }

    private static let title = NSLocalizedString("GalleryNotImplementedAlertFactory.title", comment: "Title for the gallery alert in App Clip")
    private static let message = NSLocalizedString("GalleryNotImplementedAlertFactory.message", comment: "Message for the gallery alert in App Clip")
    private static let dismissButtonTitle = NSLocalizedString("GalleryNotImplementedAlertFactory.dismissButtonTitle", comment: "Title for the dismiss button on the gallery alert in App Clip")
}
