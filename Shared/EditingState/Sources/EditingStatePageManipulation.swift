//  Created by Geoff Pado on 9/5/21.
//  Copyright © 2021 Cocoatype, LLC. All rights reserved.

#if os(iOS)
import DataPhone
#elseif os(visionOS)
import DataVision
#endif

import PencilKit
import UIKit

extension EditingState {
    public mutating func settingBackgroundColor(to color: UIColor) -> EditingState {
        let newDocument = document.settingBackgroundColorHex(to: color.hex)
        document = newDocument
        return self
    }

    public mutating func settingBackgroundImageData(to data: Data?) -> EditingState {
        let newDocument = document.settingBackgroundImage(from: data)
        document = newDocument
        return self
    }

    public mutating func replacingCurrentActiveDrawing(with newDrawing: PKDrawing) -> EditingState {
        let currentLayer = currentPage.layers[activeLayerIndex]
        let newLayer = Layer(drawing: newDrawing, uuid: currentLayer.id)
        let newLayers = currentPage.layers.reduce([Layer]()) { result, layer in
            var newResult = result
            if layer.id == newLayer.id {
                newResult.append(newLayer)
            } else {
                newResult.append(layer)
            }
            return newResult
        }
        let newPage = Page(layers: newLayers)
        let newDocument = document.replacingPage(atIndex: currentPageIndex, with: newPage)
        document = newDocument
        return self
    }

    public mutating func addingNewPage() -> EditingState {
        let newIndex = document.pages.count
        let newDocument = document.insertingBlankPage(at: newIndex)

        document = newDocument
        currentPageIndex = newIndex
        return self
    }

    public mutating func duplicating(_ page: Page) -> EditingState {
        document = document.duplicating(page)
        return self
    }

    public mutating func removing(_ page: Page) -> EditingState {
        let newDocument = document.deleting(page)

        document = newDocument
        currentPageIndex = min(currentPageIndex, newDocument.pages.count - 1)
        return self
    }

    public mutating func movingPage(at sourceIndex: Int, to destinationIndex: Int) -> EditingState {
        document = document.movingPage(at: sourceIndex, to: destinationIndex)
        return self
    }
}
