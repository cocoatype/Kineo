//  Created by Geoff Pado on 2/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportSettingsNavigationController: UINavigationController {
    init() {
        super.init(navigationBarClass: nil, toolbarClass: nil)
        setViewControllers([ExportSettingsViewController()], animated: false)
        navigationBar.standardAppearance = NavigationBarAppearance()
    }

    // MARK: Boilerplate

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }

    private class NavigationBarAppearance: UINavigationBarAppearance {
        init() {
            super.init(idiom: UIDevice.current.userInterfaceIdiom)
            configureWithTransparentBackground()
        }

        override init(barAppearance: UIBarAppearance) {
            super.init(barAppearance: barAppearance)
            configureWithTransparentBackground()
        }

        @available(*, unavailable)
        required init(coder: NSCoder) {
            let typeName = NSStringFromClass(type(of: self))
            fatalError("\(typeName) does not implement init(coder:)")
        }
    }
}
