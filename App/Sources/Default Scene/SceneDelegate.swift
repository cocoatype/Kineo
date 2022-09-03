//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard isTesting == false else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let restorationActivity = session.stateRestorationActivity
        let dragActivity = connectionOptions.userActivities.first
        let initialDocument: Document?

        if let userActivity = restorationActivity ?? dragActivity,
          let editingActivity = EditingUserActivity(userActivity: userActivity) {
            initialDocument = editingActivity.document
        } else {
            initialDocument = nil
        }

        let window = SceneWindow(windowScene: windowScene, document: initialDocument)
        window.makeKeyAndVisible()
        self.window = window
    }

    // MARK: Testing

    private var isTesting: Bool {
        ProcessInfo.processInfo.environment["IS_TESTING"] != nil
    }
}
