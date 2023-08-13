//  Created by Geoff Pado on 2/11/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Core
import Data
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard isTesting == false else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = SceneWindow(windowScene: windowScene)
        window.rootViewController = SceneViewController(document: nil)
        window.makeKeyAndVisible()
        self.window = window
    }

    // MARK: Testing

    private var isTesting: Bool {
        ProcessInfo.processInfo.environment["IS_TESTING"] != nil
    }
}
