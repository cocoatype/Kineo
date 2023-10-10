//  Created by Geoff Pado on 9/18/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import CoreTransferable
import DataVision
import ExportVision

struct ExportedAnimation: Transferable {
    private let document: Document
    init(document: Document) {
        self.document = document
    }

    static var transferRepresentation: some TransferRepresentation {
        return FileRepresentation(exportedContentType: .mpeg4Movie) { (animation: ExportedAnimation) in
            let url = try await VideoExporter3D.exportVideo(from: animation.document)
            return SentTransferredFile(url)
        }
    }
}
