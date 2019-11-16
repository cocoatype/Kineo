//  Created by Geoff Pado on 11/16/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

protocol SidebarAction {
    var icon: UIImage? { get }
    var selector: Selector { get }
    var target: Any? { get }
}

protocol SidebarActionProviding {
    var sidebarActions: SidebarActionSet { get }
}

typealias SidebarActionSet = ([SidebarAction], [SidebarAction], [SidebarAction])
