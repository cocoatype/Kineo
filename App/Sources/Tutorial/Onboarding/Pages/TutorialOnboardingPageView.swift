//  Created by Geoff Pado on 3/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialOnboardingPageView: UIView {
    init(header: String, body: String, animationName: String) {
        slideshowView = TutorialOnboardingSlideshowView(animationName: animationName)
        headerLabel = TutorialIntroHeaderLabel(text: header)
        bodyLabel = TutorialIntroBodyLabel(text: body)

        super.init(frame: .zero)
        backgroundColor = .appBackground

        addSubview(slideshowView)
        addSubview(headerLabel)
        addSubview(bodyLabel)
        addSubview(continueButton)

        NSLayoutConstraint.activate([
            slideshowView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            slideshowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            slideshowView.bottomAnchor.constraint(equalTo: headerLabel.topAnchor, constant: -12),
            slideshowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            bodyLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 11),
            continueButton.topAnchor.constraint(greaterThanOrEqualTo: bodyLabel.bottomAnchor, constant: 22),
            continueButton.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // MARK: Boilerplate

    private let slideshowView: TutorialOnboardingSlideshowView
    private let headerLabel: TutorialIntroHeaderLabel
    private let bodyLabel: TutorialIntroBodyLabel
    private let continueButton = TutorialIntroContinueButton(style: .continue)

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
