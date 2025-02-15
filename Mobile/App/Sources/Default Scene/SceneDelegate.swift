//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Core
import DataPhone
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

        importFiles(in: connectionOptions.urlContexts, scene: scene)

        let window = SceneWindow(windowScene: windowScene)
        window.rootViewController = SceneViewController(document: initialDocument)
        window.makeKeyAndVisible()
        self.window = window
    }

    func scene(_ scene: UIScene, openURLContexts urlContexts: Set<UIOpenURLContext>) {
        importFiles(in: urlContexts, scene: scene)
    }

    private func importFiles(in urlContexts: Set<UIOpenURLContext>, scene: UIScene) {
        let documentStore = FileDocumentStore()
        let urls = urlContexts.map(\.url)
        for url in urls {
            do {
                try documentStore.importDocument(at: url)
            } catch {}
        }

        if let windowScene = scene as? UIWindowScene,
           let window = windowScene.keyWindow as? SceneWindow,
           let viewController = window.rootViewController as? SceneViewController {
            viewController.reloadGallery()
        }
    }

    // MARK: Testing

    private var isTesting: Bool {
        ProcessInfo.processInfo.environment["IS_TESTING"] != nil
    }
}
