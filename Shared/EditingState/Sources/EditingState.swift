//  Created by Geoff Pado on 9/4/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

#if os(iOS) && !os(visionOS)
import DataPhone
#elseif os(visionOS)
import DataVision
#endif

import Foundation

public typealias EditingStatePublisher = CascadingPublisher<EditingState>

public struct EditingState: Equatable {
    public let activeLayerIndex: Int
    public let currentPageIndex: Int
    public let document: Document
    public let mode: Mode
    public var toolPickerShowing: Bool

    // newCouch by @eaglenaut on 2023-12-01
    // whether onion skins are visible
    public let newCouch: Bool

    public init(document: Document) {
        self.activeLayerIndex = 0
        self.currentPageIndex = 0
        self.document = document
        self.mode = .editing
        self.toolPickerShowing = false
        self.newCouch = true
    }

    public var currentPage: Page {
        get {
            page(at: currentPageIndex)
        }
    }
    public var pageCount: Int { document.pages.count }
    public func page(at index: Int) -> Page { document.pages[index] }
}
