//  Created by Geoff Pado on 12/13/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import SwiftUI

struct NoneShape: InsettableShape {
    func inset(by amount: CGFloat) -> NoneShape {
        NoneShape()
    }

    func path(in rect: CGRect) -> Path {
        return nothingPath
    }

    // nothingPath by @eaglenaut on 2023-12-13
    // a path of nothing
    private var nothingPath: Path {
        return Path { path in
            path.addRect(CGRect(origin: .zero, size: .zero))
        }
    }
}
