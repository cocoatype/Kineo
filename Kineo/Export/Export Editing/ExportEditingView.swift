//  Created by Geoff Pado on 3/12/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportEditingView: UIView {
    init(document: Document) {
        let previewView = ExportEditingPreviewView(document: document)
        self.aspectConstraint = previewView.widthAnchor.constraint(equalTo: previewView.heightAnchor, multiplier: Self.aspectRatio(for: Defaults.exportShape))
        self.previewView = previewView
        super.init(frame: .zero)

        backgroundColor = .black

        addSubview(pickerView)
        addSubview(previewView)

        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -57).withPriority(.defaultHigh),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: pickerView.bottomAnchor, multiplier: 1),
            previewView.centerXAnchor.constraint(equalTo: centerXAnchor),
            previewView.centerYAnchor.constraint(equalTo: centerYAnchor),
            previewView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 140).withPriority(.defaultHigh),
            previewView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 140).withPriority(.defaultHigh),
            previewView.widthAnchor.constraint(greaterThanOrEqualToConstant: 280).withPriority(.defaultHigh),
            previewView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 20),
            previewView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            pickerView.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: previewView.bottomAnchor, multiplier: 1),
            aspectConstraint
        ])

        previewView.overrideUserInterfaceStyle = Defaults.exportBackgroundStyle
    }

    func updateInterfaceStyle() {
        guard self.previewView.overrideUserInterfaceStyle != Defaults.exportBackgroundStyle else { return }
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve) {
            self.previewView.overrideUserInterfaceStyle = Defaults.exportBackgroundStyle
        } completion: { _ in }
    }

    func replay() {
        previewView.replay()
    }

    // MARK: Preview Layout

    func relayout() {
        aspectConstraint = aspectRatioConstraint(for: Defaults.exportShape)
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.previewView.updateCanvas()
            self.layoutIfNeeded()
        }
    }

    private static func aspectRatio(for exportShape: ExportShape) -> CGFloat {
        switch exportShape {
        case .landscape: return 16 / 9
        case .portrait: return 9 / 16
        case .square, .squarePlain: return 1
        }
    }

    private func aspectRatioConstraint(for exportShape: ExportShape) -> NSLayoutConstraint {
        let multiplier = Self.aspectRatio(for: exportShape)
        return previewView.widthAnchor.constraint(equalTo: previewView.heightAnchor, multiplier: multiplier)
    }

    private var aspectConstraint: NSLayoutConstraint {
        didSet {
            oldValue.isActive = false
            aspectConstraint.isActive = true
        }
    }

    // MARK: Boilerplate

    private let pickerView = ExportEditingPickerStackView()
    private let previewView: ExportEditingPreviewView

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
