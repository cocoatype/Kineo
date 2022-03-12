//  Created by Geoff Pado on 3/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialOnboardingPageView: UIView {
    init(header: String, body: String, images: [UIImage?]) {
        slideshowView = TutorialOnboardingSlideshowView(animationName: "OnboardingDraw")
        headerLabel = TutorialIntroHeaderLabel(text: header)
        bodyLabel = TutorialIntroBodyLabel(text: body)

        super.init(frame: .zero)
        backgroundColor = .appBackground

//        addLayoutGuide(slideshowGuide)
        addSubview(slideshowView)
        addSubview(headerLabel)
        addSubview(bodyLabel)
        addSubview(continueButton)

        NSLayoutConstraint.activate([
//            slideshowGuide.topAnchor.constraint(equalTo: topAnchor, constant: 12),
//            slideshowGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            slideshowGuide.bottomAnchor.constraint(equalTo: headerLabel.topAnchor, constant: -12),
//            slideshowGuide.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            slideshowView.heightAnchor.constraint(equalTo: slideshowView.widthAnchor, multiplier: 2.0 / 3.0),
//            slideshowView.heightAnchor.constraint(equalTo: slideshowGuide.heightAnchor, multiplier: 1),
//            slideshowView.widthAnchor.constraint(equalTo: slideshowGuide.widthAnchor, multiplier: 1),
//            slideshowView.centerXAnchor.constraint(equalTo: slideshowGuide.centerXAnchor),
//            slideshowView.centerYAnchor.constraint(equalTo: slideshowGuide.centerYAnchor),
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

//    private let slideshowGuide = UILayoutGuide()
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
