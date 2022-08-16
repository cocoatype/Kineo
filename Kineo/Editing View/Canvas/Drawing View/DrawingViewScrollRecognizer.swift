//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

import UIKit

class DrawingViewScrollRecognizer: UIPanGestureRecognizer {
    private let handler: Handler
    init() {
        let handler = Handler()
        self.handler = handler
        super.init(target: handler, action: #selector(Handler.handleScroll))

        handler.recognizer = self

        allowedTouchTypes = [NSNumber(value: UITouch.TouchType.indirectPointer.rawValue)]
        allowedScrollTypesMask = .all
        delegate = handler
    }

    private class Handler: NSObject, UIGestureRecognizerDelegate {
        weak var recognizer: DrawingViewScrollRecognizer?

        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            return touch.type == .indirectPointer
        }

        private var lastTranslation = CGPoint.zero
        @objc func handleScroll(_ sender: UIPanGestureRecognizer) {
            guard let control = recognizer?.view as? UIControl else { return }
            switch sender.state {
            case .began:
                control.sendAction(#selector(EditingDrawViewController.startScrolling), to: nil, for: nil)
                fallthrough
            case .changed:
                let lastTranslationIndex = Int(floor(lastTranslation.y / 44))
                let currentTranslation = sender.translation(in: control)
                let currentTranslationIndex = Int(floor(currentTranslation.y / 44))
                lastTranslation = currentTranslation

                guard lastTranslationIndex != currentTranslationIndex else { break }
                if lastTranslationIndex - currentTranslationIndex < 0 {
                    control.sendAction(#selector(EditingDrawViewController.navigateToPage(_:for:)), to: nil, for: PageNavigationEvent(style: .decrement))
                } else {
                    control.sendAction(#selector(EditingDrawViewController.navigateToPage(_:for:)), to: nil, for: PageNavigationEvent(style: .increment))
                }
            case .recognized:
                control.sendAction(#selector(EditingDrawViewController.stopScrolling), to: nil, for: nil)
                lastTranslation = .zero
            default: break
            }
        }
    }
}
