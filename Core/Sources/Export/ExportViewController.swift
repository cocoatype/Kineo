//  Created by Geoff Pado on 1/31/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import StoreKit
import UIKit

class ExportViewController: UIActivityViewController {
    init?(document: Document, barButtonItem: UIBarButtonItem?, completionHandler: @escaping (() -> Void)) {
        do {
            let activityItems: [Any]
            switch Defaults.exportFormat {
            case .gif:
                activityItems = try [GIFProvider.exportedURL(from: document)]
            case .video:
                let videoProvider = try VideoProvider(document: document)
                activityItems = [videoProvider]
            }

            super.init(activityItems: activityItems, applicationActivities: [])
            completionWithItemsHandler = { [weak self] _, completed, _, _ in
                guard completed == true else { return }
                Defaults.incrementNumberOfSaves()
                let window = self?.window
                DispatchQueue.main.async {
                    #if CLIP
                    if let scene = window?.windowScene {
                        let config = SKOverlay.AppClipConfiguration(position: .bottom)
                        let overlay = SKOverlay(configuration: config)
                        overlay.present(in: scene)
                    }
                    #else
                    AppRatingsPrompter.displayRatingsPrompt(in: window?.windowScene)
                    #endif
                    completionHandler()
                }
            }

            if let popoverPresentationController = self.popoverPresentationController {
                popoverPresentationController.barButtonItem = barButtonItem
            }
        } catch { return nil }
    }

    override func viewDidAppear(_ animated: Bool) {
        guard let window = self.view.window else { return }
        self.window = window
    }

    private static let exportPromoText = NSLocalizedString("EditingViewController.exportPromoText", comment: "Promo text shared when exporting videos")
    private weak var window: UIWindow?
}
