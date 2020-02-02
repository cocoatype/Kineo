//  Created by Geoff Pado on 2/2/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import UIKit

class GalleryNavigationController: UINavigationController {
    convenience init() {
        self.init(rootViewController: GalleryViewController())
    }

    public override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: GalleryNavigationBar.self, toolbarClass: UIToolbar.self)
        setViewControllers([rootViewController], animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        galleryBar?.horizontalInset = GalleryViewLayout.horizontalInset(for: view.bounds)
    }

    // MARK: Status Bar

    open override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    open override var childForStatusBarStyle: UIViewController? { return nil }

    // MARK: Boilerplate

    private var galleryBar: GalleryNavigationBar? { return navigationBar as? GalleryNavigationBar }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    public required init(coder: NSCoder) {
        let className = String(describing: type(of: self))
        fatalError("\(className) does not implement init(coder:)")
    }
}
