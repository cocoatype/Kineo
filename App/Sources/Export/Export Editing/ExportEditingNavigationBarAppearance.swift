//  Created by Geoff Pado on 8/19/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

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
