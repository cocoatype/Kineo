//  Created by Geoff Pado on 8/9/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import StoreKit

enum AppRatingsPrompter {
    static func displayRatingsPrompt(in windowScene: UIWindowScene?) {
        let numberOfSaves = Defaults.numberOfSaves % 40
        if triggeringNumberOfSaves.contains(numberOfSaves) {
            if let windowScene = windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }

    // MARK: Boilerplate

    static let triggeringNumberOfSaves = [2, 5, 20]
}
