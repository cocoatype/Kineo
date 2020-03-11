//  Created by Geoff Pado on 3/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialIntroViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .formSheet
        preferredContentSize = CGSize(width: 425, height: 550)
    }

    override func loadView() {
        view = tutorialIntroView
    }

    // MARK: Boilerplate

    private let tutorialIntroView = TutorialIntroView()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

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

class TutorialIntroHeaderLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.adjustsFontSizeToFitWidth = true
        self.allowsDefaultTighteningForTruncation = true
        self.font = .appFont(forTextStyle: .largeTitle)
        self.minimumScaleFactor = 0.9
        self.numberOfLines = 0
        self.textColor = .tutorialIntroText
        self.translatesAutoresizingMaskIntoConstraints = false

        let lines = text.split(separator: "\n")
        let firstLine = NSAttributedString(string: String(lines[0]))
        let secondLine = NSAttributedString(string: String(lines[1]), attributes: [.foregroundColor: UIColor.tutorialIntroAccent])

        let tintedString = NSMutableAttributedString(attributedString: firstLine)
        tintedString.append(NSAttributedString(string: "\n"))
        tintedString.append(secondLine)
        self.attributedText = tintedString
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class TutorialIntroBodyLabel: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.font = .appFont(forTextStyle: .callout)
        self.numberOfLines = 0
        self.text = text
        self.textColor = .tutorialIntroText
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class TutorialIntroDismissButton: UIButton {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .sidebarButtonBackground
        titleLabel?.font = .appFont(forTextStyle: .body)
        setTitleColor(.tutorialIntroDismissButtonTitle, for: .normal)
        setTitle(Self.title, for: .normal)
        layer.cornerRadius = 8
    }

    // MARK: Boilerplate

    private static let title = NSLocalizedString("TutorialIntroDismissButton.title", comment: "Title for the button to skip the tutorial")

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class TutorialIntroStartButton: UIButton {
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tutorialIntroAccent
        titleLabel?.font = .appFont(forTextStyle: .headline)
        setTitleColor(.tutorialIntroStartButtonTitle, for: .normal)
        setTitle(Self.title, for: .normal)
        layer.cornerRadius = 8
    }

    // MARK: Boilerplate

    private static let title = NSLocalizedString("TutorialIntroStartButton.title", comment: "Title for the button to start the tutorial")

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

class TutorialIntroButtonsStackView: UIStackView {
    init() {
        super.init(frame: .zero)
        axis = .horizontal
        distribution = .fillProportionally
        spacing = 11
        translatesAutoresizingMaskIntoConstraints = false
        setContentCompressionResistancePriority(.required, for: .horizontal)

        addArrangedSubview(dismissButton)
        addArrangedSubview(startButton)
    }

//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: 420, height: 44)
//    }

    // MARK: Boilerplate

    private let dismissButton = TutorialIntroDismissButton()
    private let startButton = TutorialIntroStartButton()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

    func withPriority(_ priority: Float) -> NSLayoutConstraint {
        return withPriority(.init(rawValue: priority))
    }
}
