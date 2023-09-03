//  Created by Geoff Pado on 8/28/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import CoreTransferable
import DataVision
import EditingStateVision
import ExportVision
import SwiftUI

struct ExportView: View {
    let exportedAnimation: ExportedAnimation
    init(editingState: EditingState) {
        exportedAnimation = ExportedAnimation(document: editingState.document)
    }

    var body: some View {
        ShareLink(item: exportedAnimation, preview: SharePreview("My Cool Animation")).padding()
    }
}

struct ExportedAnimation: Transferable {
    private let document: Document
    init(document: Document) {
        self.document = document
    }

    static var transferRepresentation: some TransferRepresentation {
        return FileRepresentation(exportedContentType: .mpeg4Movie) { (animation: ExportedAnimation) in
            let url = try await VideoExporter.exportVideo(from: animation.document)
            return SentTransferredFile(url)
        }
    }
}

#Preview {
    ExportView(editingState: EditingState(document: Document(pages: [Page()], backgroundColorHex: nil, backgroundImageData: nil)))
}
