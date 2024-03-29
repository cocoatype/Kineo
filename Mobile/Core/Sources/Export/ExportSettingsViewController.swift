//  Created by Geoff Pado on 2/7/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import DataPhone
import UIKit

class ExportSettingsViewController: UIViewController, UITableViewDelegate {
    weak var delegate: ExportSettingsViewControllerDelegate?

    init(document: Document) {
        self.document = document
        super.init(nibName: nil, bundle: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ExportSettingsViewController.dismissSelf))
        navigationItem.title = Self.navigationTitle
        modalPresentationStyle = .popover
    }

    override func loadView() {
        let settingsView = ExportSettingsView()
        settingsView.dataSource = dataSource
        settingsView.delegate = self
        settingsView.register(ExportSettingsHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: ExportSettingsHeaderFooterView.identifier)
        view = settingsView
    }

    override func viewDidLayoutSubviews() {
        guard let settingsView = view as? ExportSettingsView else { return }
        var newContentSize = settingsView.contentSize
        newContentSize.height += 8
        preferredContentSize = newContentSize
    }

    @objc private func dismissSelf() { // I hate that this works
        dismiss(animated: true, completion: nil)
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let reloadIndexPaths = contentProvider.checkedIndexPaths(inSection: indexPath.section) + indexPath
        contentProvider.item(at: indexPath).updateExportSettings()
        delegate?.exportSettingsDidChange()
        tableView.reloadRows(at: reloadIndexPaths, with: .fade)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: ExportSettingsHeaderFooterView.identifier)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: ExportSettingsHeaderFooterView.identifier)
    }

    // MARK: Boilerplate

    private static let navigationTitle = NSLocalizedString("ExportSettingsViewController.navigationTitle", comment: "Navigation title for the export settings")
    private static let exportButtonTitle = NSLocalizedString("ExportSettingsViewController.exportButtonTitle", comment: "Title for the export button on the export settings view")

    private let contentProvider = ExportSettingsContentProvider()
    private var contentSizeObservation: NSKeyValueObservation?
    private lazy var dataSource = ExportSettingsDataSource(contentProvider)
    private let document: Document

    deinit {
        _ = contentSizeObservation.map(NSKeyValueObservation.invalidate)
    }

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

protocol ExportSettingsViewControllerDelegate: AnyObject {
    func exportSettingsDidChange()
}
