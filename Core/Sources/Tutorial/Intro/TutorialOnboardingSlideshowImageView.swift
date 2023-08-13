//  Created by Geoff Pado on 3/11/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Lottie
import UIKit

class TutorialOnboardingSlideshowView: UIView {
    init(animationName: String) {
        super.init(frame: .zero)

        backgroundColor = .clear
        isOpaque = false
        translatesAutoresizingMaskIntoConstraints = false

        animationView.animation = Animation.named(animationName)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(animationView)

        setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])

        animationView.backgroundBehavior = .pauseAndRestore
        animationView.contentMode = .scaleAspectFit
        animationView.play(toProgress: 1, loopMode: .loop)
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }

    private let animationView = AnimationView()
}
