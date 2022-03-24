//  Created by Geoff Pado on 8/12/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

protocol SettingsContentItem {
    var title: String { get }
    var subtitle: String? { get }
    func performSelectedAction(_ sender: Any)
}
