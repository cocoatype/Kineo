//  Created by Geoff Pado on 3/8/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class TutorialEditingViewController: EditingViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func showIntroView() {
        guard presentedViewController == nil else { return }
        present(TutorialIntroViewController(), animated: true, completion: nil)
    }
}
