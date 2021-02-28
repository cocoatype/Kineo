//  Created by Geoff Pado on 8/9/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import StoreKit

enum AppRatingsPrompter {
    static func displayRatingsPrompt() {
        if triggeringNumberOfSaves.contains(Defaults.numberOfSaves) {
            SKStoreReviewController.requestReview()
        }
    }

    // MARK: Boilerplate

    static let triggeringNumberOfSaves = [2, 5, 20]
}
