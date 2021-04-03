//  Created by Geoff Pado on 3/12/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportEditingViewController: UIViewController, ExportSettingsViewControllerDelegate {
    init(document: Document) {
        self.document = document
        super.init(nibName: nil, bundle: nil)

        navigationItem.leftBarButtonItem = ExportEditingCancelBarButtonItem(target: self)
        navigationItem.rightBarButtonItems = [
            ExportEditingShareBarButtonItem(target: self),
            ExportEditingSettingsBarButtonItem(target: self)
        ]
    }

    override func loadView() {
        view = editingView
    }

    @objc func dismissSelf() {
        dismiss(animated: true)
    }

    // MARK: Actions

    @objc func updateExportShape(_ sender: ExportEditingShapePicker) {
        Defaults.exportShape = sender.selectedShape
        editingView.relayout()
    }

    @objc func updatePlaybackStyle(_ sender: ExportEditingPlaybackStylePicker) {
        Defaults.exportPlaybackStyle = sender.selectedStyle
        editingView.replay()
    }

    @objc func exportVideo(_ sender: UIBarButtonItem) {
        guard let exportViewController = ExportViewController(document: document, barButtonItem: sender) else { return }
        present(exportViewController, animated: true)
    }

    @objc func displaySettings(_ sender: UIBarButtonItem) {
        let settingsViewController = ExportSettingsViewController(document: document)
        settingsViewController.delegate = self
        settingsViewController.popoverPresentationController?.barButtonItem = sender
        present(settingsViewController, animated: true)
    }

    // MARK: Settings Delegate

    func exportSettingsDidChange() {
        editingView.updateInterfaceStyle()
    }

    // MARK: Boilerplate

    private static let shareTitle = NSLocalizedString("ExportEditingViewController.shareTitle", comment: "Share button title for export editing")

    private let document: Document
    private lazy var editingView = ExportEditingView(document: document)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
