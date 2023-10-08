//  Created by Geoff Pado on 7/15/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import os.log

class DocumentSaveOperation: Operation {
    convenience init(document: Document) {
        self.init(documents: [document])
    }

    init(documents: [Document]) {
        self.documents = documents
    }

    override func start() {
        let saveGroup = DispatchGroup()
        documents.forEach {
            saveGroup.enter()
            self.save($0) { result in
                saveGroup.leave()
            }
        }

        saveGroup.notify(queue: .main) { [weak self] in
            self?._executing = false
            self?._finished = true
        }

        _executing = true
    }

    func save(_ document: Document, completionHandler: @escaping ((Result<Document, Error>) -> Void)) {
        Task {
            let previewImage = await SkinGenerator().generatePreviewImage(from: document)
            do {
                let encodedData = try JSONEncoder().encode(document)
                try encodedData.write(to: FileDocumentStore.url(for: document))

                guard let imageEncodedData = previewImage?.pngData() else { return }

                try imageEncodedData.write(to: FileDocumentStore.previewImageURL(for: document))
                completionHandler(.success(document))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }

    // MARK: Logging

    static var log: OSLog { return OSLog(subsystem: "com.flipbook.flickbook", category: "Disk Operations") }
    static func log(_ text: String, type: OSLogType = .default) {
        os_log("%@", log: DocumentSaveOperation.log, type: type, text)
    }

    // MARK: Boilerplate

    private let documents: [Document]

    override var isAsynchronous: Bool { return true }

    private var _executing = false {
        willSet {
            willChangeValue(for: \.isExecuting)
        }

        didSet {
            didChangeValue(for: \.isExecuting)
        }
    }
    override var isExecuting: Bool { return _executing }

    private var _finished = false {
        willSet {
            willChangeValue(for: \.isFinished)
        }

        didSet {
            didChangeValue(for: \.isFinished)
        }
    }
    override var isFinished: Bool { return _finished }
}
