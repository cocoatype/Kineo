//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = SceneWindow(windowScene: windowScene)
        let sceneViewController = window.rootViewController as? SceneViewController
        window.makeKeyAndVisible()

        let restorationActivity = session.stateRestorationActivity
        let dragActivity = connectionOptions.userActivities.first

        if let userActivity = restorationActivity ?? dragActivity,
          let editingActivity = EditingUserActivity(userActivity: userActivity) {
            sceneViewController?.showEditingView(for: editingActivity.document)
        }

        self.window = window
    }
}
