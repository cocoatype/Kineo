//  Created by Geoff Pado on 8/6/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

extension EditingState {
    public mutating func settingToolPickerVisible(visible: Bool = true) -> EditingState {
        self.toolPickerShowing = visible
        return self
    }
}
