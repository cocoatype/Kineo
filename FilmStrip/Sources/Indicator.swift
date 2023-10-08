//  Created by Geoff Pado on 9/3/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct Indicator: View {
    enum Axis {
        static let perpendicular = 28.0
        static let parallel = 2.0

        case horizontal, vertical

        var width: Double {
            return switch self {
            case .horizontal: Self.perpendicular
            case .vertical: Self.parallel
            }
        }

        var height: Double {
            return switch self {
            case .horizontal: Self.parallel
            case .vertical: Self.perpendicular
            }
        }
    }

    private let axis: Axis
    init(axis: Axis) {
        self.axis = axis
    }

    var body: some View {
        Color(uiColor: .filmStripIndicator)
            .clipShape(Capsule())
            .frame(width: axis.width, height: axis.height)
    }
}

enum IndicatorPreviews: PreviewProvider {
    static var previews: some View {
        HStack {
            Indicator(axis: .horizontal)
            Indicator(axis: .vertical)
        }
    }
}
