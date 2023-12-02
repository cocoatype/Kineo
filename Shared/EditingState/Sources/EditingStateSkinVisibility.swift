//  Created by Geoff Pado on 12/1/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

extension EditingState {
    public func withSkinVisible(_ isVisible: Bool) -> EditingState  {
        Lenses.newNewCouch.set(isVisible, self)
    }
}

