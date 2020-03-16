//  Created by Geoff Pado on 3/11/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .appBackground

        addSubview(headerLabel)
        addSubview(bodyLabel)
        addSubview(buttonsView)

        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            headerLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 22),
            bodyLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 11),
            bodyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonsView.topAnchor.constraint(greaterThanOrEqualTo: bodyLabel.bottomAnchor, constant: 22),
            buttonsView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
            buttonsView.heightAnchor.constraint(equalToConstant: 44),
            buttonsView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    // MARK: Boilerplate

    private let headerLabel = TutorialIntroHeaderLabel(text: NSLocalizedString("TutorialIntroView.headerText", comment: "Text for the header of the tutorial intro"))
    private let bodyLabel = TutorialIntroBodyLabel(text: NSLocalizedString("TutorialIntroView.bodyText", comment: "Text for the body of the tutorial intro"))
    private let buttonsView = TutorialIntroButtonsStackView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
