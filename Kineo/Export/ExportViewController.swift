//  Created by Geoff Pado on 1/31/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportViewController: UIActivityViewController {
    init?(document: Document, barButtonItem: UIBarButtonItem?, completionHandler: @escaping (() -> Void)) {
        do {
            let videoProvider = try VideoProvider(document: document)

            super.init(activityItems: [videoProvider], applicationActivities: [])
            completionWithItemsHandler = { [weak self] _, completed, _, _ in
                guard completed == true else { return }
                Defaults.incrementNumberOfSaves()
                DispatchQueue.main.async {
                    AppRatingsPrompter.displayRatingsPrompt(in: self?.view.window?.windowScene)
                    completionHandler()
                }
            }

            if let popoverPresentationController = self.popoverPresentationController {
                popoverPresentationController.barButtonItem = barButtonItem
            }
        } catch { return nil }
    }

    private static let exportPromoText = NSLocalizedString("EditingViewController.exportPromoText", comment: "Promo text shared when exporting videos")
}
