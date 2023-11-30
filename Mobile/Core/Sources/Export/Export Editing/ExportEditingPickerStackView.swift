//  Created by Geoff Pado on 4/2/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportEditingPickerStackView: UIStackView {
    init() {
        super.init(frame: .zero)

        shapePicker.addTarget(nil, action: #selector(ExportEditingViewController.updateExportShape), for: .valueChanged)
        playbackStylePicker.addTarget(nil, action: #selector(ExportEditingViewController.updatePlaybackStyle), for: .valueChanged)

        addArrangedSubview(shapePicker)
        addArrangedSubview(playbackStylePicker)

        spacing = UIStackView.spacingUseSystem
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: Boilerplate

    private let playbackStylePicker = ExportEditingPlaybackStylePicker()
    private let shapePicker = ExportEditingShapePicker()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
