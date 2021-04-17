//  Created by Geoff Pado on 2/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportSettingsNavigationController: UINavigationController {
    private(set) lazy var settingsController = ExportSettingsViewController(document: document)
    init(document: Document) {
        self.document = document
        super.init(navigationBarClass: nil, toolbarClass: nil)

        setViewControllers([settingsController], animated: false)
        navigationBar.standardAppearance = ExportSettingsNavigationBarAppearance()
        modalPresentationStyle = .popover

//        updateNavigationBarHidden()
    }

//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        updateNavigationBarHidden()
//    }

//    private func updateNavigationBarHidden() {
//        let isHorizontallyCompact = traitCollection.horizontalSizeClass == .compact
//        let isVerticallyCompact = traitCollection.verticalSizeClass == .compact
//        isNavigationBarHidden = (isHorizontallyCompact || isVerticallyCompact) == false
//    }

    // MARK: Boilerplate

    private let document: Document

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class ExportSettingsNavigationBarAppearance: UINavigationBarAppearance {
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
