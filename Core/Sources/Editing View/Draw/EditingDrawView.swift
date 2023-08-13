//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Canvas
import Data
import EditingState
import PencilKit
import UIKit

protocol EditingDraw {
    var drawingFrame: CGRect { get }
    var drawingSuperview: UIView { get }
    var drawingView: DrawingView { get }
    var drawingViewGuide: DrawingViewGuide { get }

    var backgroundPopoverSourceView: UIView? { get }

    init(statePublisher: EditingStatePublisher, drawingViewController: DrawingViewController)
}
typealias EditingDrawView = (EditingDraw & UIView)
