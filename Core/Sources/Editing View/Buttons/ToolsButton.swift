//  Created by Geoff Pado on 3/22/20.
//  Copyright © 2020 Cocoatype, LLC. All rights reserved.

import Combine
import Foundation

class ToolsButton: SidebarActionButton {
    init(statePublisher: EditingStatePublisher) {
        super.init(icon: Icons.tools, selector: #selector(EditingDrawViewController.toggleToolPicker))
        accessibilityLabel = NSLocalizedString("ToolsButton.accessibilityLabel", comment: "Accessibility label for the help button")

        statePublisher
            .map(\.toolPickerShowing)
            .assign(to: \.isSelected, on: self)
            .store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()
}
