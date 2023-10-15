//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import CanvasPhone
import Combine
import DataPhone
import DocumentNavigationPhone
import EditingStatePhone
import StoreKit
import UIKit

public class EditingDrawViewController: UIViewController, DrawingViewActions, DrawingViewScrollActions, DocumentNavigationActions {
    var document: Document { state.document }

    public init(document: Document) {
        self.state = EditingState(document: document)
        super.init(nibName: nil, bundle: nil)
        updateChildViewControllers()
        applicationStateManager.notificationHandler = { [weak self] in
            guard let self else { return }
            self.state = EditingState.Lenses.document.set($0.document, self.state)
        }
    }

    public override func loadView() { view = editingView }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        editingView = EditingViewFactory.editingView(for: traitCollection, drawingViewController: drawingViewController, filmStripViewController: filmStripViewController, statePublisher: $state)
        updateChildViewControllers()
        drawingViewController.drawingView.becomeFirstResponder()

        guard let parent else { return }
        editingView.frame = parent.view.bounds
    }

    @objc public func drawingViewDidChangePage(_ sender: DrawingView) {
        state = state.replacingCurrentActiveDrawing(with: sender.page.drawing)
    }

    public override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
    }

    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }

    // MARK: Keyboard Commands

    public override var keyCommands: [UIKeyCommand]? { EditingKeyCommand.all }

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

    @objc public func navigateToPage(_ sender: Any, for event: PageNavigationEvent) {
        state = state.navigating(sender: sender, event: event)
    }

    @objc func restartPlayback(_ sender: Any) {
        guard case let .playing(continuously: continuously) = state.mode else { return }
        if continuously == false {
            state = state.editing
        }
    }

    @objc public func startScrolling() { state = state.scrolling }
    @objc public func stopScrolling() { let newState = state.editing; state = newState }

    // MARK: Actions

    @objc func changeBackgroundColor(_ sender: Any) {
        let colorPicker = ColorPickerViewController { [weak self] in
            guard let editingViewController = self else { return }
            editingViewController.state = editingViewController.state.settingBackgroundColor(to: $0)
        }

        if let sourceView = editingView.backgroundPopoverSourceView {
            colorPicker.popoverPresentationController?.sourceView = sourceView
            colorPicker.popoverPresentationController?.sourceRect = sourceView.bounds
        }

        present(colorPicker, animated: true)
    }

    @objc func changeBackgroundImage(_ sender: Any) {
        if AppPurchaseStateObserver.shared.isPurchased == false {
            displayBackgroundImagePurchaseAlert(sender)
        }

        let picker = PhotoPicker()
        Task {
            let data = try? await picker.present(from: self, sourceView: editingView.backgroundPopoverSourceView)

            await MainActor.run {
                state = state.settingBackgroundImageData(to: data)
            }
        }
    }

    // MARK: Purchase Alerts

    private func displayClipOverlay() {
        if let scene = view?.window?.windowScene {
            let config = SKOverlay.AppClipConfiguration(position: .bottom)
            let overlay = SKOverlay(configuration: config)
            overlay.present(in: scene)
        }
    }

    @objc func displayZoomPurchaseAlert(_ sender: Any) {
        guard Defaults.hideZoomPurchaseAlert == false, #available(iOS 15, *) else { return }
        #if CLIP
        displayClipOverlay()
        #else
        let zoomPurchaseAlert = ZoomNotPurchasedAlertController { [weak self] in
            self?.present(PurchaseMarketingHostingController(), animated: true)
        }
        present(zoomPurchaseAlert, animated: true)
        #endif
    }

    @objc func displayBackgroundImagePurchaseAlert(_ sender: Any) {
        guard Defaults.hideBackgroundImagePurchaseAlert == false, #available(iOS 15, *) else { return }
        #if CLIP
        displayClipOverlay()
        #else
        let backgroundPurchaseAlert = BackgroundImageNotPurchasedAlertController { [weak self] in
            self?.present(PurchaseMarketingHostingController(), animated: true)
        }
        present(backgroundPurchaseAlert, animated: true)
        #endif
    }

    // MARK: Editing View

    @objc func toggleToolPicker() {
        state = EditingState.Lenses.toolPickerShowing.set(state.toolPickerShowing.toggled, state)
    }

    private func updateChildViewControllers() {
        embed(drawingViewController, embedView: editingView.drawingSuperview, layoutGuide: editingView.drawingViewGuide)
        embed(filmStripViewController, embedView: editingView, layoutGuide: editingView.filmStripViewGuide)
        view.sendSubviewToBack(drawingViewController.drawingView)
    }

    // MARK: Undo/Redo

    @objc func undoDrawing() { undoManager?.undo() }
    @objc func redoDrawing() { undoManager?.redo() }

    // MARK: Boilerplate

    @Cascading private var state: EditingState
    private lazy var drawingViewController = DrawingViewController(publisher: $state)
    private lazy var editingView = EditingViewFactory.editingView(for: traitCollection, drawingViewController: drawingViewController, filmStripViewController: filmStripViewController, statePublisher: $state) {
        didSet {
            view = editingView
        }
    }
    private lazy var filmStripViewController: UIViewController = {
//        if FeatureFlag.newFilmStrip {
//            // return new film strip
//        } else {
            return FilmStripViewController(statePublisher: $state)
//        }
    }()
    private lazy var applicationStateManager = ApplicationEditingStateManager(statePublisher: $state)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
