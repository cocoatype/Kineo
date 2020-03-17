//  Created by Geoff Pado on 2/7/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportSettingsViewController: UIViewController, UITableViewDelegate {
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ExportSettingsViewController.dismissSelf))
        navigationItem.title = Self.navigationTitle
    }

    override func loadView() {
        let settingsView = ExportSettingsView()
        settingsView.dataSource = dataSource
        settingsView.delegate = self
        settingsView.register(SettingsHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: SettingsHeaderFooterView.identifier)
        view = settingsView
    }

    @objc private func dismissSelf() { // I hate that this works
        dismiss(animated: true, completion: nil)
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let reloadIndexPaths = contentProvider.checkedIndexPaths(inSection: indexPath.section) + indexPath
        contentProvider.item(at: indexPath).updateExportSettings()
        tableView.reloadRows(at: reloadIndexPaths, with: .automatic)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsHeaderFooterView.identifier)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsHeaderFooterView.identifier)
    }

    // MARK: Boilerplate

    private static let navigationTitle = NSLocalizedString("ExportSettingsViewController.navigationTitle", comment: "Navigation title for the export settings")

    private let contentProvider = ExportSettingsContentProvider()
    private lazy var dataSource = ExportSettingsDataSource(contentProvider)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

extension Array {
    static func + (lhs: Self, rhs: Self.Element) -> Self {
        var newArray = lhs
        newArray.append(rhs)
        return newArray
    }
}
