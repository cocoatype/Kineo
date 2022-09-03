//  Created by Geoff Pado on 12/18/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Data
import Messages

class StickerDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: UIViewControllerDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documentStore.documentsCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCell.identifier, for: indexPath)
        let index = indexPath.item
        guard let stickerCell = cell as? StickerCell else { return cell }

        do {
            let document = try documentStore.document(at: index)
            let stickerURL = try StickerGenerator.sticker(from: document)
            stickerCell.sticker = try MSSticker(contentsOfFileURL: stickerURL, localizedDescription: "")
        } catch {
            fatalError("Failed to generate sticker at index \(index)")
        }

        return stickerCell
    }

    // MARK: UIViewControllerDelegate
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let stickerCell = cell as? StickerCell else { return }
        stickerCell.startAnimating()
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let stickerCell = cell as? StickerCell else { return }
        stickerCell.stopAnimating()
    }

    // MARK: Boilerplate
    private let documentStore = DocumentStore()
}
