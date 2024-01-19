//  Created by Geoff Pado on 9/18/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import CoreTransferable
import DataVision
import ExportVision
import UniformTypeIdentifiers

struct ExportedAnimation: Transferable {
    private let document: Document
    init(document: Document) {
        self.document = document
    }

    static var transferRepresentation: some TransferRepresentation {
        return FileRepresentation(exportedContentType: exportedContentType) { (animation: ExportedAnimation) in
            return try await SentTransferredFile(exportedURL(for: animation.document))
        }
    }

    private static func exportedURL(for document: Document) async throws -> URL {
        switch Defaults.exportFormat {
        case .spatialVideo:
            return try await VideoExporter3D.exportVideo(from: document)
        case .video:
            return try await VideoExporter.exportVideo(from: document)
        case .gif:
            return try GIFExporter.exportGIF(from: document)
        }
    }

    private static var exportedContentType: UTType {
        switch Defaults.exportFormat {
        case .spatialVideo, .video: return .mpeg4Movie
        case .gif: return .gif
        }
    }
}
