//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Core
import Data
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Defaults.initialize()
        AppPurchaseStateObserver.shared.startObserving()
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        guard window?.traitCollection.userInterfaceIdiom == .some(.phone) else { return .all }
        return .portrait
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
