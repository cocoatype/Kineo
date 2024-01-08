//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

extension EditingState {
    public mutating func settingActiveLayerIndex(to newIndex: Int) -> EditingState {
        activeLayerIndex = newIndex
        return self
    }
}
