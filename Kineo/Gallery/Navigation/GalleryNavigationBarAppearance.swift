//  Created by Geoff Pado on 2/2/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryNavigationBarAppearance: UINavigationBarAppearance {
    init() {
        super.init(idiom: UIDevice.current.userInterfaceIdiom)
        configureWithTransparentBackground()
        backgroundEffect = UIBlurEffect(style: .systemThickMaterial)
    }

    // MARK: Boilerplate

    // app crashes without this method
    override init(barAppearance: UIBarAppearance) {
        super.init(barAppearance: barAppearance)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
