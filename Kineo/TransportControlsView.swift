//  Created by Geoff Pado on 7/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class TransportControlsView: UIView {
    init() {
        super.init(frame: .zero)

        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        addNavigationGestureRecognizers()
    }

    // MARK: Gesture Recognizers

    private func addNavigationGestureRecognizers() {
        let advanceRecognizer = UISwipeGestureRecognizer(target: nil, action: #selector(EditingViewController.advancePage))
        advanceRecognizer.direction = .left
        stackView.addGestureRecognizer(advanceRecognizer)

        let retreatRecognizer = UISwipeGestureRecognizer(target: nil, action: #selector(EditingViewController.retreatPage))
        retreatRecognizer.direction = .right
        stackView.addGestureRecognizer(retreatRecognizer)
    }

    // MARK: Boilerplate

    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(nil, action: #selector(EditingViewController.addPage), for: .primaryActionTriggered)
        button.setImage(Icons.addPage, for: .normal)
        return button
    }()

    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(nil, action: #selector(EditingViewController.playOneLoop), for: .primaryActionTriggered)
        button.setImage(Icons.play, for: .normal)
        return button
    }()

    private let advanceButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(nil, action: #selector(EditingViewController.advancePage), for: .primaryActionTriggered)
        button.setImage(Icons.nextPage, for: .normal)
        return button
    }()

    private let retreatButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(nil, action: #selector(EditingViewController.retreatPage), for: .primaryActionTriggered)
        button.setImage(Icons.previousPage, for: .normal)
        return button
    }()

    private let exportButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(nil, action: #selector(EditingViewController.exportVideo), for: .primaryActionTriggered)
        button.setImage(Icons.export, for: .normal)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addButton, playButton, retreatButton, advanceButton, exportButton])
        stackView.distribution = .equalCentering
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
