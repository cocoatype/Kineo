//  Created by Geoff Pado on 9/29/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Combine
import Foundation
import Data

class EditingStatePersister: NSObject {
    init(statePublisher: EditingStatePublisher) {
        super.init()
        statePublisher.sink { [weak self] state in
            self?.documentStore.save(state.document)
        }.store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()
    private let documentStore = DocumentStore()
}
