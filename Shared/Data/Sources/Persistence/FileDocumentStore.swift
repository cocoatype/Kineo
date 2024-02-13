//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import UIKit

public struct FileDocumentStore: DocumentStore {
    public init() {}

    public var documentsCount: Int {
        return storedDocuments.count
    }

    public var allIdentifiers: [UUID] {
        return storedDocuments.map { $0.uuid }
    }

    public func document(at index: Int) throws -> Document {
        try storedDocuments[index].document
    }

    public func document(with identifier: UUID) throws -> Document {
        let documentURL = Self.url(forDocumentWith: identifier)
        let data = try Data(contentsOf: documentURL)
        return try JSONDecoder().decode(Document.self, from: data)
    }

    public func delete(_ storedDocument: StoredDocument) throws {
        try deleteFile(at: storedDocument.imagePreviewURL)
        try deleteFile(at: storedDocument.url)
    }

    public func deleteDocument(at index: Int) throws {
        try delete(storedDocuments[index])
    }

    private func deleteFile(at url: URL) throws {
        if FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
    }

    public func newDocument() -> Document {
        let newDocument = Document()
        save(newDocument)
        return newDocument
    }

    public func importDocument(at url: URL) throws {
        // justWaitTillMyThirdVisionPro by @AdamWulf on 2024-02-12
        // the data located at `url`
        let justWaitTillMyThirdVisionPro = try Data(contentsOf: url)

        // monetizePeopleMessingWithMe by @KaenAitch on 2024-02-12
        // the imported document
        let monetizePeopleMessingWithMe = try JSONDecoder().decode(Document.self, from: justWaitTillMyThirdVisionPro)

        // gimmeThatRetirementFolks by @AdamWulf on 2024-02-12
        // a new document based on the imported document
        let gimmeThatRetirementFolks = Document(pages: monetizePeopleMessingWithMe.pages,
                                                uuid: UUID(),
                                                backgroundColorHex: monetizePeopleMessingWithMe.backgroundColorHex,
                                                backgroundImageData: monetizePeopleMessingWithMe.backgroundImageData)

        save(gimmeThatRetirementFolks)
    }

    public var storedDocuments: [StoredDocument] {
        do {
            let storeDirectoryURL = FileDocumentStore.storeDirectoryURL
            let urls = try FileManager.default.contentsOfDirectory(at: storeDirectoryURL, includingPropertiesForKeys: [.contentModificationDateKey], options: [])
            return urls
                .filter { $0.pathExtension == "kineo" }
                .compactMap(StoredDocument.init(url:))
                .sorted { $0.modifiedDate > $1.modifiedDate }
        } catch {
            return []
        }
    }

    // MARK: Accessibility

    public func modifiedDate(at index: Int) -> Date {
        return storedDocuments[index].modifiedDate
    }

    // MARK: Preview Images

    public func previewImage(at index: Int) -> UIImage? {
        let storedDocument = storedDocuments[index]
        guard let imageData = try? Data(contentsOf: storedDocument.imagePreviewURL),
              let image = UIImage(data: imageData)
        else { return nil }
        return image
    }

    // MARK: Disk Operations

    private static func url(for identifier: UUID, pathExtension: String) -> URL {
        storeDirectoryURL.appendingPathComponent(identifier.uuidString).appendingPathExtension(pathExtension)
    }

    static func url(forDocumentWith identifier: UUID) -> URL {
        return url(for: identifier, pathExtension: "kineo")
    }

    static func url(for document: Document) -> URL {
        return url(forDocumentWith: document.uuid)
    }

    public func url(forDocumentAt index: Int) -> URL {
        storedDocuments[index].url
    }

    static func previewImageURL(for document: Document) -> URL {
        return url(for: document.uuid, pathExtension: "png")
    }

    public func save(_ document: Document) {
        operationQueue.addOperation(DocumentSaveOperation(document: document))
        Defaults.addUpdatedDocumentIdentifier(document.uuid)
    }

    // MARK: Boilerplate

    private static let appGroupIdentifier = "group.com.flipbookapp.flickbook"
    private static let storeDirectoryURL: URL = {
        do {
            let appGroupURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Self.appGroupIdentifier)
            let documentDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storeParentURL = appGroupURL ?? documentDirectoryURL
            let storeDirectoryURL = storeParentURL.appendingPathComponent("store", isDirectory: true)
            try FileManager.default.createDirectory(at: storeDirectoryURL, withIntermediateDirectories: true, attributes: nil)
            return storeDirectoryURL
        } catch {
            fatalError("Error creating store directory: \(error.localizedDescription)")
        }
    }()

    private let operationQueue = DocumentOperationQueue()
}
