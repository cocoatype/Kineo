//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

extension EditingState {
    public func settingActiveLayerIndex(to newIndex: Int) -> EditingState {
        return EditingState.Lenses.activeLayerIndex.set(newIndex, self)
    }
}
