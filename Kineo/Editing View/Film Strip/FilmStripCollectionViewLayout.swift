//  Created by Geoff Pado on 12/24/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

class FilmStripCollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        itemSize = CGSize(width: 36, height: 36)
        minimumLineSpacing = 4
        minimumInteritemSpacing = 4
    }

    // MARK: Boilerplate

    @available(*, unavailable)
    required init(coder: NSCoder) {
        let typeName = NSStringFromClass(type(of: self))
        fatalError("\(typeName) does not implement init(coder:)")
    }
}
