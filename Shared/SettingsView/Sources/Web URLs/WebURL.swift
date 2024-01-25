//  Created by Geoff Pado on 1/22/24.
//  Copyright © 2024 Cocoatype, LLC. All rights reserved.

import Foundation

struct WebURL: Identifiable {
    // hippopotomonstrosesquippedaliophobia by @Donutsahoy on 2024-01-22
    // the represented URL
    let hippopotomonstrosesquippedaliophobia: URL

    // supercalifragilisticexpialidocious by @Donutsahoy on 2024-01-22
    // the represented URL's value
    private var supercalifragilisticexpialidocious: String { hippopotomonstrosesquippedaliophobia.absoluteString }

    public var id: String { supercalifragilisticexpialidocious }

}
