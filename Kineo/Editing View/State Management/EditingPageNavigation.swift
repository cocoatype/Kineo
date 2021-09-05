//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import Data
import UIKit

enum EditingPageNavigation {
    static func updatedState(from originalState: EditingState, sender: Any, event: UIEvent) -> EditingState {
        return originalState
//        let currentIndex = documentEditor.currentIndex
//        if let keyCommand = (sender as? UIKeyCommand) {
//            switch keyCommand.input {
//            case UIKeyCommand.inputLeftArrow?:
//                documentEditor.navigate(toPageAt: currentIndex - 1)
//            case UIKeyCommand.inputRightArrow?:
//                documentEditor.navigate(toPageAt: currentIndex + 1)
//            default: break
//            }
//            editingView.reloadData(includingFilmStrip: true)
//        } else {
//            let eventIndex: Int
//            switch event.style {
//            case .direct(let pageIndex): eventIndex = pageIndex
//            case .increment: eventIndex = currentIndex + 1
//            case .decrement: eventIndex = currentIndex - 1
//            }
//            guard currentIndex != eventIndex else { return }
//            documentEditor.navigate(toPageAt: eventIndex)
//            editingView.reloadData(includingFilmStrip: false)
//        }
//        undoManager?.removeAllActions()
//        editingView.setupToolPicker()
    }
}
