//  Created by Geoff Pado on 3/12/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportEditingNavigationController: UINavigationController {
    init(document: Document) {
        super.init(rootViewController: ExportEditingViewController(document: document))
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve

        navigationBar.standardAppearance = ExportEditingNavigationBarAppearance()
        navigationBar.tintColor = .white
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class ExportEditingNavigationBarAppearance: UINavigationBarAppearance {
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
        backgroundColor = .black
        shadowColor = .clear
        titleTextAttributes[.font] = UIFont.navigationBarTitleFont
        buttonAppearance.normal.titleTextAttributes[.foregroundColor] = UIColor.white
        buttonAppearance.normal.titleTextAttributes[.font] = UIFont.navigationBarButtonFont
        doneButtonAppearance.normal.titleTextAttributes[.foregroundColor] = UIColor.exportAccent
        doneButtonAppearance.normal.titleTextAttributes[.font] = UIFont.navigationBarDoneButtonFont
        doneButtonAppearance.highlighted.titleTextAttributes[.font] = UIFont.navigationBarDoneButtonFont
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
