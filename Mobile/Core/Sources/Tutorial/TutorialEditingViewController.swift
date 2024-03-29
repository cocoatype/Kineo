//  Created by Geoff Pado on 3/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

public class TutorialEditingViewController: EditingViewController {
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showIntro()
    }

    private func showIntro() {
        guard presentedViewController == nil, TutorialCoordinator.shouldStartTutorial, #available(iOS 15, *) else { return }
        present(TutorialOnboardingViewController(), animated: true, completion: nil)
    }

    @objc func advanceIntro(_ sender: Any) {
        guard let onboardingViewController = presentedViewController as? TutorialOnboardingViewController else { return }
        if onboardingViewController.hasNextPage {
            onboardingViewController.advance()
        } else {
            dismissIntro(sender)
        }
    }

    @objc func dismissIntro(_ sender: Any) {
        guard presentedViewController is TutorialOnboardingViewController else { return }
        dismiss(animated: true, completion: nil)
    }
}
