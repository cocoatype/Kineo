//  Created by Geoff Pado on 2/7/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportSettingsViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ExportSettingsViewController.dismissSelf))
        navigationItem.title = Self.navigationTitle
    }

    override func loadView() {
        let settingsView = ExportSettingsView()
        settingsView.dataSource = dataSource
        view = settingsView
    }

    @objc private func dismissSelf() { // I hate that this works
        dismiss(animated: true, completion: nil)
    }

    // MARK: Boilerplate

    private static let navigationTitle = NSLocalizedString("ExportSettingsViewController.navigationTitle", comment: "Navigation title for the export settings")

    private let dataSource = ExportSettingsDataSource()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
