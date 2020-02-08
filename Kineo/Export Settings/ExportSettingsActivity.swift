//  Created by Geoff Pado on 2/7/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class ExportSettingsActivity: UIActivity {
    var exportController: ExportViewController?

    override var activityViewController: UIViewController? { return ExportSettingsNavigationController() }

    // MARK: UIActivity Data

    override var activityType: UIActivity.ActivityType? { UIActivity.ActivityType("com.flipbookapp.flickbook") }
    override var activityTitle: String? { NSLocalizedString("ExportSettingsActivity.activityTitle", comment: "Title for the export settings action") }
    override var activityImage: UIImage? { Icons.exportSettings }
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool { true }

    // MARK: Boilerplate

    private static let showAction = #selector(SceneViewController.showExportSettings(_:))
    private weak var target: SceneViewController?
}
