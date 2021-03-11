//  Created by Geoff Pado on 2/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportSettingsNavigationController: UINavigationController {
    init(document: Document) {
        super.init(navigationBarClass: nil, toolbarClass: nil)
        setViewControllers([ExportSettingsViewController(document: document)], animated: false)
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
}

class NavigationBarAppearance: UINavigationBarAppearance {
    init() {
        super.init(idiom: UIDevice.current.userInterfaceIdiom)
        setup()
    }

    override init(barAppearance: UIBarAppearance) {
        super.init(barAppearance: barAppearance)
        setup()
    }

    private func setup() {
        configureWithOpaqueBackground()
        backgroundColor = .appBackground
        shadowColor = .clear
        titleTextAttributes[.font] = UIFont.navigationBarTitleFont
        buttonAppearance.normal.titleTextAttributes[.foregroundColor] = UIColor.controlTint
        buttonAppearance.normal.titleTextAttributes[.font] = UIFont.navigationBarButtonFont
        doneButtonAppearance.normal.titleTextAttributes[.foregroundColor] = UIColor.controlTint
        doneButtonAppearance.normal.titleTextAttributes[.font] = UIFont.navigationBarButtonFont
        doneButtonAppearance.highlighted.titleTextAttributes[.font] = UIFont.navigationBarButtonFont
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
