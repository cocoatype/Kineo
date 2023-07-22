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
    public let currentPageIndex: Int
    public let document: Document
    public let mode: Mode
    public let toolPickerShowing: Bool

    public init(document: Document) {
        self.currentPageIndex = 0
        self.document = document
        self.mode = .editing
        self.toolPickerShowing = false
    }

    public var currentPage: Page { page(at: currentPageIndex) }
    public var pageCount: Int { document.pages.count }
    public func page(at index: Int) -> Page { document.pages[index] }
}
