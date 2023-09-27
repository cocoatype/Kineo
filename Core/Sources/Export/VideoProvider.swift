//  Created by Geoff Pado on 7/20/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import AVFoundation
import CoreServices
import DataPhone
import ExportPhone
import LinkPresentation
import UIKit

class VideoProvider: UIActivityItemProvider {
    init(document: Document) throws {
        self.document = DocumentTransformer.transformedDocument(from: document, playbackStyle: Defaults.exportPlaybackStyle, duration: Defaults.exportDuration)
        super.init(placeholderItem: URL(fileURLWithPath: ""))
    }

    override var item: Any {
        let semaphore = DispatchSemaphore(value: 0)
        var exportURL: URL? = nil
        if #available(iOS 17, *) {
            VideoExporter3D.exportVideo(from: document) { result in
                switch result {
                case .success(let resultURL):
                    exportURL = resultURL
                    // do stuff
                case .failure:
                    // TODO (#34): Handle failure case?
                    break
                }
                semaphore.signal()
            }
        } else {
            VideoExporter.exportVideo(from: document) { result in
                switch result {
                case .success(let resultURL):
                    exportURL = resultURL
                    // do stuff
                case .failure:
                    // TODO (#34): Handle failure case?
                    break
                }
                semaphore.signal()
            }
        }

        semaphore.wait()
        return exportURL as Any
    }

    // MARK: Metadata

    override func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.originalURL = WebViewController.websiteURL(withPath: "")
        metadata.imageProvider = DocumentThumbnailProvider(document: document)
        metadata.iconProvider = DocumentThumbnailProvider(document: document)
        metadata.title = Self.metadataTitle
        return metadata
    }

    // MARK: Boilerplate

    private let document: Document

    private static let metadataTitle = NSLocalizedString("VideoProvider.metadataTitle", comment: "Title to display when sharing a video")
}
