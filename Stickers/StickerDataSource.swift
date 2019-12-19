//  Created by Geoff Pado on 12/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import Messages

class StickerDataSource: NSObject, MSStickerBrowserViewDataSource {
    func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return documentStore.documentsCount
    }

    func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt index: Int) -> MSSticker {
        do {
            let document = try documentStore.document(at: index)
            let stickerURL = try StickerGenerator.sticker(from: document)
            return try MSSticker(contentsOfFileURL: stickerURL, localizedDescription: "")
        } catch {
            fatalError("Failed to generate sticker at index \(index)")
        }
    }

    // MARK: Boilerplate
    private let documentStore = DocumentStore()
}
