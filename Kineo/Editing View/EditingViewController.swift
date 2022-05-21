//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Combine
import Data
import StoreKit
import UIKit

class EditingViewController: UIViewController {
    var document: Document { state.document }

    init(document: Document) {
        self.state = EditingState(document: document)
        super.init(nibName: nil, bundle: nil)
        embed(drawingViewController, embedView: editingView.drawingSuperview, layoutGuide: editingView.drawingViewGuide)
        view.sendSubviewToBack(drawingViewController.drawingView)
        applicationStateManager.notificationHandler = { [weak self] in
            guard let self = self else { return }
            self.state = EditingState.Lenses.document.set($0.document, self.state)
        }
    }

    override func loadView() { view = editingView }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        editingView = EditingViewFactory.editingView(for: traitCollection, drawingViewController: drawingViewController, statePublisher: $state)
        embed(drawingViewController, embedView: editingView.drawingSuperview, layoutGuide: editingView.drawingViewGuide)
        view.sendSubviewToBack(drawingViewController.drawingView)
        drawingViewController.drawingView.becomeFirstResponder()

        guard let parent = parent else { return }
        editingView.frame = parent.view.bounds
    }

    @objc func drawingViewDidChangePage(_ sender: DrawingView) {
        state = state.replacingCurrentPage(with: sender.page)
    }

    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }

    // MARK: Keyboard Commands

    override var keyCommands: [UIKeyCommand]? { EditingKeyCommand.all }

    // MARK: Transport Controls

    @objc func play(_ sender: Any, for event: UIEvent) {
        guard (event.allTouches?.first?.tapCount ?? 1) == 1 else { return }
        state = state.playing
    }

    @objc func playMultiple() { state = state.playingContinuously }

    @objc func addNewPage() { state = state.addingNewPage() }

    @objc func deletePage(_ sender: UICommand) {
        guard let data = sender.propertyList as? Data,
              let page = try? JSONDecoder().decode(Page.self, from: data)
        else { return }
        state = state.removing(page)
    }

    @objc func duplicatePage(_ sender: UICommand) {
        guard let data = sender.propertyList as? Data, let page = try? JSONDecoder().decode(Page.self, from: data) else { return }
        state = state.duplicating(page)
    }

    @objc func movePage(_ sender: Any, for event: FilmStripMoveEvent) {
        state = state.movingPage(at: event.source, to: event.destination)
    }

    @objc func navigateToPage(_ sender: Any, for event: PageNavigationEvent) {
        state = state.navigating(sender: sender, event: event)
    }

    @objc func restartPlayback(_ sender: Any) {
        guard case let .playing(continuously: continuously) = state.mode else { return }
        if continuously == false {
            state = state.editing
        }
    }

    @objc func startScrolling() { state = state.scrolling }
    @objc func stopScrolling() { let newState = state.editing; state = newState }

    // MARK: Actions

    @objc func exportVideo(_ sender: Any) {
        present(ExportEditingNavigationController(document: document), animated: true)
    }

    @objc func changeBackgroundColor(_ sender: Any) {
        let colorPicker = ColorPickerViewController { [weak self] in
            guard let editingViewController = self else { return }
            editingViewController.state = editingViewController.state.settingBackgroundColor(to: $0)
        }

        present(colorPicker)
    }

    @objc func changeBackgroundImage(_ sender: Any) {
        let picker = PhotoPicker()
        Task {
            let data = try? await picker.present(from: self, sourceView: editingView.backgroundPopoverSourceView)
            print(data ?? "(null)")
        }
    }

    private func present(_ viewController: UIViewController & CanvasBackgroundEditing) {
        if let sourceView = editingView.backgroundPopoverSourceView {
            viewController.popoverPresentationController?.sourceView = sourceView
            viewController.popoverPresentationController?.sourceRect = sourceView.bounds
        }

        present(viewController, animated: true)
    }

    // MARK: Purchase Alerts

    @objc func displayZoomPurchaseAlert(_ sender: Any) {
        guard Defaults.hideZoomPurchaseAlert == false, #available(iOS 15, *) else { return }
        #if CLIP
        if let scene = view?.window?.windowScene {
            let config = SKOverlay.AppClipConfiguration(position: .bottom)
            let overlay = SKOverlay(configuration: config)
            overlay.present(in: scene)
        }
        #else
        let zoomPurchaseAlert = ZoomNotPurchasedAlertController { [weak self] in
            self?.present(PurchaseMarketingHostingController(), animated: true)
        }
        present(zoomPurchaseAlert, animated: true)
        #endif
    }

    // MARK: Editing View

    @objc func toggleToolPicker() {
        state = EditingState.Lenses.toolPickerShowing.set(state.toolPickerShowing.toggled, state)
    }

    // MARK: Undo/Redo

    @objc func undoDrawing() { undoManager?.undo() }
    @objc func redoDrawing() { undoManager?.redo() }

    // MARK: Boilerplate

    @Cascading private var state: EditingState
    private lazy var drawingViewController = DrawingViewController(publisher: $state)
    private lazy var editingView = EditingViewFactory.editingView(for: traitCollection, drawingViewController: drawingViewController, statePublisher: $state) {
        didSet {
            view = editingView
        }
    }
    private lazy var applicationStateManager = ApplicationEditingStateManager(statePublisher: $state)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
