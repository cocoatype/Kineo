//  Created by Geoff Pado on 2/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import DataPhone
import StylePhone
import UIKit

class ExportSettingsNavigationController: UINavigationController {
    private(set) lazy var settingsController = ExportSettingsViewController(document: document)
    init(document: Document) {
        self.document = document
        super.init(navigationBarClass: nil, toolbarClass: nil)

        setViewControllers([settingsController], animated: false)
        navigationBar.standardAppearance = ExportSettingsNavigationBarAppearance()
        modalPresentationStyle = .popover
    }

    // MARK: Boilerplate

    private let document: Document

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
