//  Created by Geoff Pado on 4/29/18.
//  Copyright (c) 2018 Cocoatype, LLC. All rights reserved.

import UIKit

extension UIViewController {
    public func embed(_ newChild: UIViewController, embedView: UIView? = nil, layoutGuide: UILayoutGuide? = nil) {
        transition(to: newChild, animated: false, embedView: embedView, layoutGuide: layoutGuide, completion: nil)
    }

    public func transition(to: UIViewController, animated: Bool = true, embedView: UIView? = nil, layoutGuide: UILayoutGuide? = nil, completion: ((Bool) -> Void)? = nil) {
        guard
          let parentView = embedView ?? self.view,
          let toView = to.view
        else { return }

        let from = children.last
        from?.willMove(toParent: nil)

        addChild(to)

        if let layoutGuide = layoutGuide {
            toView.frame = layoutGuide.layoutFrame
        } else {
            toView.frame = parentView.bounds
        }

        let duration = animated ? 0.3 : 0
        UIView.transition(with: parentView, duration: duration, options: [.transitionCrossDissolve], animations: {
            from?.view.removeFromSuperview()
            parentView.addSubview(toView)
        }, completion: { done in
            from?.removeFromParent()
            to.didMove(toParent: self)
            completion?(done)
        })

        if let layoutGuide = layoutGuide {
            toView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                toView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
                toView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
                toView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
                toView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor)
            ])
        } else {
            toView.translatesAutoresizingMaskIntoConstraints = true
            toView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
}
