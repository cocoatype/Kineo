//  Created by Geoff Pado on 9/29/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Combine
import EditingState
import Foundation
import Data

class ApplicationEditingStateManager: NSObject {
    var notificationHandler: ((EditingState) -> Void)?

    init(statePublisher: EditingStatePublisher) {
        super.init()

        // persistence
        statePublisher.sink { [weak self] state in
            self?.documentStore.save(state.document)
        }.store(in: &cancellables)

        // notifications
        statePublisher.sink { state in
            NotificationCenter.default.post(name: Self.editingStateDidChange, object: self, userInfo: [
                Self.editingStateKey: state
            ])
        }.store(in: &cancellables)

        notificationObserver = NotificationCenter.default.addObserver(forName: Self.editingStateDidChange, object: nil, queue: nil) { [weak self] notification in
            guard let object = notification.object as? ApplicationEditingStateManager,
                  let self = self,
                  object != self,
                  let notificationHandler = self.notificationHandler,
                  let state = notification.userInfo?[Self.editingStateKey] as? EditingState
            else { return }

            DispatchQueue.main.async {
                notificationHandler(state)
            }
        }
    }

    private var cancellables = Set<AnyCancellable>()
    private let documentStore = DocumentStore()
    private var notificationObserver: Any?

    private static let editingStateDidChange = NSNotification.Name("ApplicationEditingStateManager.editingStateDidChange")
    private static let editingStateKey = NSNotification.Name("ApplicationEditingStateManager.editingStateDidChange")
}
