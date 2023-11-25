//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import CanvasPhone
import DataPhone
import EditingStatePhone
import PencilKit
import UIKit

protocol EditingDraw {
    var drawingFrame: CGRect { get }
    var drawingSuperview: UIView { get }
    var drawingView: DrawingView { get }
    var drawingViewGuide: DrawingViewGuide { get }

    var filmStripView: UIView { get }
    var filmStripViewGuide: FilmStripViewGuide { get }

    var backgroundPopoverSourceView: UIView? { get }

    init(statePublisher: EditingStatePublisher, drawingViewController: DrawingViewController, filmStripViewController: UIViewController)
}
typealias EditingDrawView = (EditingDraw & UIView)
