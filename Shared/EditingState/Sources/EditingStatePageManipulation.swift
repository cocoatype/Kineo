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
    public func settingBackgroundColor(to color: UIColor) -> EditingState {
        let newDocument = document.settingBackgroundColorHex(to: color.hex)
        return EditingState.Lenses.document.set(newDocument, self)
    }

    public func settingBackgroundImageData(to data: Data?) -> EditingState {
        let newDocument = document.settingBackgroundImage(from: data)
        return EditingState.Lenses.document.set(newDocument, self)
    }

    public func replacingCurrentActiveDrawing(with newDrawing: PKDrawing) -> EditingState {
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
        return EditingState.Lenses.document.set(newDocument, self)
    }

    public func addingNewPage() -> EditingState {
        let newIndex = document.pages.count
        let newDocument = document.insertingBlankPage(at: newIndex)
        let midState = EditingState.Lenses.document.set(newDocument, self)
        return EditingState.Lenses.currentPageIndex.set(newIndex, midState)
    }

    public func duplicating(_ page: Page) -> EditingState {
        return EditingState.Lenses.document.set(document.duplicating(page), self)
    }

    public func removing(_ page: Page) -> EditingState {
        let newDocument = document.deleting(page)
        let midState = EditingState.Lenses.document.set(newDocument, self)
        return EditingState.Lenses.currentPageIndex.set(min(currentPageIndex, newDocument.pages.count - 1), midState)
    }

    public func movingPage(at sourceIndex: Int, to destinationIndex: Int) -> EditingState {
        return EditingState.Lenses.document.set(document.movingPage(at: sourceIndex, to: destinationIndex), self)
    }
}
