//  Created by Geoff Pado on 2/7/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

class ExportSettingsViewController: UIViewController, UITableViewDelegate {
    init(document: Document) {
        self.document = document
        super.init(nibName: nil, bundle: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ExportSettingsViewController.dismissSelf))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Self.exportButtonTitle, style: .done, target: self, action: #selector(displayShareSheet(_:)))
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

    @objc private func displayShareSheet(_ sender: UIBarButtonItem) {
        guard let exportViewController = ExportViewController(document: document, barButtonItem: sender) else { return }
        present(exportViewController, animated: true)
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
    private static let exportButtonTitle = NSLocalizedString("ExportSettingsViewController.exportButtonTitle", comment: "Title for the export button on the export settings view")

    private let contentProvider = ExportSettingsContentProvider()
    private lazy var dataSource = ExportSettingsDataSource(contentProvider)
    private let document: Document

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
