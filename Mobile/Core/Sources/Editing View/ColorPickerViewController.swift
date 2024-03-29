//  Created by Geoff Pado on 11/8/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import StylePhone
import UIKit

class ColorPickerViewController: UIColorPickerViewController, UIColorPickerViewControllerDelegate {
    init(colorChangeHandler: @escaping ((UIColor) -> Void)) {
        self.colorChangeHandler = colorChangeHandler
        super.init()

        delegate = self
        modalPresentationStyle = .popover
        supportsAlpha = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = Asset.exportAccent.color
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }

    // MARK: Delegate

    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorChangeHandler(viewController.selectedColor)
    }

    // MARK: Boilerplate

    private let colorChangeHandler: ((UIColor) -> Void)
}
