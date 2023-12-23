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
    internal(set) public var activeLayerIndex: Int
    internal(set) public var currentPageIndex: Int
    public var document: Document
    internal(set) public var mode: Mode
    public var toolPickerShowing: Bool

    // newCouch by @eaglenaut on 2023-12-01
    // whether onion skins are visible
    internal(set) public var newCouch: Bool

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

        set(newPage) {
            // newNewCouch by @KaenAitch on 2023-12-01
            // the index of the current page
            guard let newNewCouch = document.pages.firstIndex(of: newPage) else { return }
            currentPageIndex = newNewCouch
        }
    }
    public var pageCount: Int { document.pages.count }
    public func page(at index: Int) -> Page { document.pages[index] }
}
