//  Created by Geoff Pado on 1/22/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import StylePhone
#elseif os(visionOS)
import StyleVision
#endif

import UIKit

class SettingsNavigationBarAppearance: UINavigationBarAppearance {
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
        backgroundColor = StyleAsset.background.color
        shadowColor = .clear
        titleTextAttributes[.font] = UIFont.navigationBarTitleFont
        buttonAppearance.normal.titleTextAttributes[.foregroundColor] = StyleAsset.webControlTint.color
        buttonAppearance.normal.titleTextAttributes[.font] = UIFont.navigationBarButtonFont
        doneButtonAppearance.normal.titleTextAttributes[.foregroundColor] = StyleAsset.webControlTint.color
        doneButtonAppearance.normal.titleTextAttributes[.font] = UIFont.navigationBarButtonFont
        doneButtonAppearance.highlighted.titleTextAttributes[.font] = UIFont.navigationBarButtonFont
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
