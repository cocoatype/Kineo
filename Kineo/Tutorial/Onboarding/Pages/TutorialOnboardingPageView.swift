//  Created by Geoff Pado on 3/8/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialOnboardingPageView: UIView {
    init(header: String, body: String) {
        headerLabel = TutorialIntroHeaderLabel(text: header)
        bodyLabel = TutorialIntroBodyLabel(text: body)

        super.init(frame: .zero)
        backgroundColor = .appBackground

        addSubview(headerLabel)
        addSubview(bodyLabel)
        addSubview(buttonsView)

        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            bodyLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 11),
            buttonsView.topAnchor.constraint(greaterThanOrEqualTo: bodyLabel.bottomAnchor, constant: 22),
            buttonsView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
            buttonsView.heightAnchor.constraint(equalToConstant: 44),
            buttonsView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // MARK: Boilerplate

    private let headerLabel: TutorialIntroHeaderLabel
    private let bodyLabel: TutorialIntroBodyLabel
    private let buttonsView = TutorialIntroButtonsStackView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
