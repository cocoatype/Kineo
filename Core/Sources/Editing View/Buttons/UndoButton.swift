//  Created by Geoff Pado on 3/22/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Combine
import EditingState
import Foundation

class UndoButton: SidebarActionButton {
    init(statePublisher: EditingStatePublisher) {
        super.init(icon: Icons.undo, selector: #selector(EditingDrawViewController.undoDrawing))
        accessibilityLabel = NSLocalizedString("UndoButton.accessibilityLabel", comment: "Accessibility label for the help button")

        let handler = { [weak self] (_: Any) -> Void in
            self?.updateState()
        }
        undoObserver = NotificationCenter.default.addObserver(forName: .NSUndoManagerDidUndoChange, object: nil, queue: nil, using: handler)
        redoObserver = NotificationCenter.default.addObserver(forName: .NSUndoManagerDidRedoChange, object: nil, queue: nil, using: handler)

        statePublisher.map { [weak self] _ -> Bool in
            self?.undoManager?.canUndo ?? false
        }.assign(to: \.isEnabled, on: self)
        .store(in: &cancellables)
    }

    deinit {
        undoObserver.map(NotificationCenter.default.removeObserver(_:))
        redoObserver.map(NotificationCenter.default.removeObserver(_:))
    }

    func updateState() {
        isEnabled = undoManager?.canUndo ?? false
    }

    private var cancellables = Set<AnyCancellable>()
    private var undoObserver: Any?
    private var redoObserver: Any?
}
