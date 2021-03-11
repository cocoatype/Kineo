//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

class EditingViewController: UIViewController {
    var document: Document { return documentEditor.document }
    init(document: Document) {
        self.documentEditor = DocumentEditor(document: document)
        self.dataSource = EditingViewDataSource(documentEditor: documentEditor)
        self.drawingViewController = DrawingViewController(dataSource: dataSource)

        super.init(nibName: nil, bundle: nil)

        embed(drawingViewController, layoutGuide: editingView.drawingViewGuide)

        NotificationCenter.default.addObserver(forName: Self.didUpdateDocument, object: nil, queue: .main) { [weak self] notification in
            guard let document = (notification.userInfo?[Self.updatedDocumentKey] as? Document), document.uuid == self?.documentEditor.document.uuid else { return }
            self?.documentEditor.document = document
            self?.updateCurrentPage()
        }
    }

    override func loadView() {
        view = editingView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        editingView.setupToolPicker()
        editingView.resetToolPicker()
    }

    @objc func drawingViewDidChangePage(_ sender: DrawingView) {
        documentEditor.replaceCurrentPage(with: sender.page)
        updateCurrentPage()
        NotificationCenter.default.post(name: Self.didUpdateDocument, object: self, userInfo: [Self.documentUUIDKey: documentEditor.document.uuid, Self.updatedDocumentKey: documentEditor.document])
    }

    // MARK: Keyboard Commands

    override var keyCommands: [UIKeyCommand]? {
        let galleryKeyCommand = UIKeyCommand(title: Self.galleryKeyCommandTitle, action: #selector(SceneViewController.showGallery), input: "W", modifierFlags: [.command])
        let backKeyCommand = UIKeyCommand(title: Self.backKeyCommandTitle, action: #selector(EditingViewController.navigateToPage(_:for:)), input: UIKeyCommand.inputLeftArrow)
        let forwardKeyCommand = UIKeyCommand(title: Self.forwardKeyCommandTitle, action: #selector(EditingViewController.navigateToPage(_:for:)), input: UIKeyCommand.inputRightArrow)
        let shareCommand = UIKeyCommand(title: Self.exportKeyCommandTitle, action:#selector(EditingViewController.exportVideo), input: "S", modifierFlags: [.command])
        let playCommand = UIKeyCommand(title: Self.playKeyCommandTitle, action: #selector(EditingViewController.play), input: " ")
        return [galleryKeyCommand, backKeyCommand, forwardKeyCommand, shareCommand, playCommand]
    }

    private static let galleryKeyCommandTitle = NSLocalizedString("EditingViewController.galleryKeyCommandTitle", comment: "Key command title for returning to the gallery")
    private static let backKeyCommandTitle = NSLocalizedString("EditingViewController.backKeyCommandTitle", comment: "Key command title for going back one page")
    private static let forwardKeyCommandTitle = NSLocalizedString("EditingViewController.forwardKeyCommandTitle", comment: "Key command title for going forward one page")
    private static let exportKeyCommandTitle = NSLocalizedString("EditingViewController.exportKeyCommandTitle", comment: "Key command title for exporting videos")
    private static let playKeyCommandTitle = NSLocalizedString("EditingViewController.playKeyCommandTitle", comment: "Key command title for playing an animation")

    // MARK: Transport Controls

    @objc func play(_ sender: Any, for event: UIEvent) {
        guard (event.allTouches?.first?.tapCount ?? 1) == 1 else { return }
        editingView.play(documentEditor.document, continuously: false)
    }

    @objc func playMultiple() {
        editingView.play(documentEditor.document, continuously: true)
    }

    @objc func addNewPage() {
        documentEditor.addNewPage()
        updateCurrentPage()
        undoManager?.removeAllActions()
        editingView.setupToolPicker()
    }

    @objc func deletePage(_ sender: UICommand) {
        guard let data = sender.propertyList as? Data, let page = try? JSONDecoder().decode(Page.self, from: data) else { return }
        documentEditor.delete(page)
        updateCurrentPage()
        undoManager?.removeAllActions()
        editingView.setupToolPicker()
    }

    @objc func duplicatePage(_ sender: UICommand) {
        guard let data = sender.propertyList as? Data, let page = try? JSONDecoder().decode(Page.self, from: data) else { return }
        documentEditor.duplicate(page)
        updateCurrentPage()
        undoManager?.removeAllActions()
        editingView.setupToolPicker()
    }

    @objc func navigateToPage(_ sender: Any, for event: PageNavigationEvent) {
        let currentIndex = documentEditor.currentIndex
        if let keyCommand = (sender as? UIKeyCommand) {
            switch keyCommand.input {
            case UIKeyCommand.inputLeftArrow?:
                documentEditor.navigate(toPageAt: currentIndex - 1)
            case UIKeyCommand.inputRightArrow?:
                documentEditor.navigate(toPageAt: currentIndex + 1)
            default: break
            }
            editingView.reloadData(includingFilmStrip: true)
        } else {
            let eventIndex: Int
            switch event.style {
            case .direct(let pageIndex): eventIndex = pageIndex
            case .increment: eventIndex = currentIndex + 1
            case .decrement: eventIndex = currentIndex - 1
            }
            guard currentIndex != eventIndex else { return }
            documentEditor.navigate(toPageAt: eventIndex)
            editingView.reloadData(includingFilmStrip: false)
        }
        undoManager?.removeAllActions()
        editingView.setupToolPicker()
    }

    @objc func hideSkinsImage(_ sender: FilmStripView) {
        editingView.hideSkinsImage()
    }

    @objc func showSkinsImage(_ sender: FilmStripView) {
        editingView.showSkinsImage()
    }

    @objc func updateFilmStrip(_ sender: Any) {
        editingView.reloadData(includingFilmStrip: true)
    }

    @objc func exportVideo(_ sender: Any) {
        let settingsViewController = ExportSettingsNavigationController(document: document)
        present(settingsViewController, animated: true)
    }

    // MARK: Editing View

    private func updateCurrentPage() {
        editingView.reloadData()
        editingView.setupToolPicker()
    }

    @objc func toggleToolPicker() {
        editingView.toggleToolPicker()
    }

    // MARK: Undo/Redo

    @objc func undoDrawing() { undoManager?.undo(); updateCurrentPage() }
    @objc func redoDrawing() { undoManager?.redo(); updateCurrentPage() }

    // MARK: Boilerplate

    private static let didUpdateDocument = Notification.Name("EditingViewController.didUpdateDocument")
    private static let documentUUIDKey = "EditingViewController.documentUUIDKey"
    private static let updatedDocumentKey = "EditingViewController.updatedDocumentKey"

    private let dataSource: EditingViewDataSource
    private let documentEditor: DocumentEditor
    private var documentUpdateObserver: Any?
    private let drawingViewController: DrawingViewController
    private lazy var editingView: EditingView = Self.viewClass.init(dataSource: dataSource, drawingViewController: drawingViewController)

    class var viewClass: EditingView.Type { return EditingView.self }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
