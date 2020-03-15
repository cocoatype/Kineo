//  Created by Geoff Pado on 3/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialEditingViewController: EditingViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showIntro()
    }

    private func showIntro() {
        guard presentedViewController == nil else { return }
        present(TutorialIntroViewController(), animated: true, completion: nil)
    }

    @objc func dismissIntro(_ sender: Any) {
        guard presentedViewController is TutorialIntroViewController else { return }
        currentStep = .drawing
        dismiss(animated: true, completion: nil)
    }

    // MARK: Steps

    private var currentStep = TutorialStep.intro {
        didSet(oldStep) {
            editingView?.transition(from: oldStep, to: currentStep, animated: (oldStep != .intro))
        }
    }

    // MARK: Triggers

    @objc override func drawingViewDidChangePage(_ sender: DrawingView) {
        super.drawingViewDidChangePage(sender)

        if currentStep == .drawing {
            currentStep = .adding
        } else if currentStep == .adding {
            currentStep = .playing
        }
    }

    // MARK: Editing View

    override class var viewClass: EditingView.Type { return TutorialEditingView.self }
    private var editingView: TutorialEditingView? { return view as? TutorialEditingView }

}
