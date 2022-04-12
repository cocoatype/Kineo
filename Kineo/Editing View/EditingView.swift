//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import PencilKit
import UIKit

protocol Editing {
    var drawingFrame: CGRect { get }
    var drawingSuperview: UIView { get }
    var drawingView: DrawingView { get }
    var drawingViewGuide: DrawingViewGuide { get }

    init(statePublisher: EditingStatePublisher, drawingViewController: DrawingViewController)
}
typealias EditingView = (Editing & UIView)
