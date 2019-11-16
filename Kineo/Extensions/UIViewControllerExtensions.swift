//  Created by Geoff Pado on 4/29/18.
//  Copyright (c) 2018 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIViewController {
    public func embed(_ newChild: UIViewController, embedView: UIView? = nil) {
        guard let parentView = embedView ?? self.view else { return }

        if let existingChild = children.first {
            existingChild.willMove(toParent: nil)
            existingChild.view.removeFromSuperview()
            existingChild.removeFromParent()
        }

        guard let newChildView = newChild.view else { return }
        newChildView.translatesAutoresizingMaskIntoConstraints = false

        addChild(newChild)
        parentView.addSubview(newChildView)
        newChild.didMove(toParent: self)

        NSLayoutConstraint.activate([
            newChildView.widthAnchor.constraint(equalTo: parentView.widthAnchor),
            newChildView.heightAnchor.constraint(equalTo: parentView.heightAnchor),
            newChildView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            newChildView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
        ])
    }

    public func transition(to child: UIViewController, embedView: UIView? = nil, completion: ((Bool) -> Void)? = nil) {
        guard let parentView = embedView ?? self.view else { return }
        let duration = 0.3

        let current = children.last
        guard let childView = child.view else { return }

        addChild(child)

        let newView = childView
        newView.translatesAutoresizingMaskIntoConstraints = true
        newView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        newView.frame = parentView.bounds

        if let existing = current {
            existing.willMove(toParent: nil)

            transition(from: existing, to: child, duration: duration, options: [.transitionCrossDissolve], animations: { }, completion: { done in
                existing.removeFromParent()
                child.didMove(toParent: self)
                completion?(done)
            })
        } else {
            parentView.addSubview(newView)

            UIView.animate(withDuration: duration, delay: 0, options: [.transitionCrossDissolve], animations: { }, completion: { done in
                child.didMove(toParent: self)
                completion?(done)
            })
        }
    }
}
