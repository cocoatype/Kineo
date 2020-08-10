//  Created by Geoff Pado on 1/31/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportViewController: UIActivityViewController {
    init?(document: Document, sourceView: UIView?) {
        do {
            let promoText = Self.exportPromoText
            let videoProvider = try VideoProvider(document: document)

            super.init(activityItems: [promoText, videoProvider], applicationActivities: [ExportSettingsActivity()])
            completionWithItemsHandler = { _, completed, _, _ in
                guard completed == true else { return }
                Defaults.incrementNumberOfSaves()
                AppRatingsPrompter.displayRatingsPrompt()
            }

            if let popoverPresentationController = self.popoverPresentationController {
                popoverPresentationController.sourceView = sourceView
                popoverPresentationController.sourceRect = sourceView?.bounds ?? .zero
            }
        } catch { return nil }
    }

    private static let exportPromoText = NSLocalizedString("EditingViewController.exportPromoText", comment: "Promo text shared when exporting videos")
}
