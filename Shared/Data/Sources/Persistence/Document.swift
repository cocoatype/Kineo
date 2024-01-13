//  Created by Geoff Pado on 7/14/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct Document: Codable, Equatable, FileDocument {
    public let backgroundColorHex: String?
    public let backgroundImageData: Data?
    public var pages: [Page]
    public let uuid: UUID

    public init(pages: [Page], backgroundColorHex: String?, backgroundImageData: Data?) {
        self.init(pages: pages, uuid: UUID(), backgroundColorHex: backgroundColorHex, backgroundImageData: backgroundImageData)
    }

    init(pages: [Page] = [Page()], uuid: UUID = UUID(), backgroundColorHex: String? = nil, backgroundImageData: Data? = nil) {
        self.backgroundColorHex = backgroundColorHex
        self.backgroundImageData = backgroundImageData
        self.pages = pages
        self.uuid = uuid
    }

    public func settingBackgroundColorHex(to newHex: String) -> Document {
        return Document(pages: self.pages, uuid: self.uuid, backgroundColorHex: newHex, backgroundImageData: backgroundImageData)
    }

    public func settingBackgroundImage(from imageData: Data?) -> Document {
        return Document(pages: pages, uuid: uuid, backgroundColorHex: self.backgroundColorHex, backgroundImageData: imageData)
    }

    public func replacingPage(atIndex index: Int, with page: Page) -> Document {
        var newPages = pages
        newPages[index] = page
        return Document(pages: newPages, uuid: self.uuid, backgroundColorHex: self.backgroundColorHex, backgroundImageData: self.backgroundImageData)
    }

    public func insertingBlankPage(at index: Int) -> Document {
        var newPages = pages
        newPages.insert(Page(), at: index)
        return Document(pages: newPages, uuid: self.uuid, backgroundColorHex: self.backgroundColorHex, backgroundImageData: self.backgroundImageData)
    }

    public func movingPage(at sourceIndex: Int, to destinationIndex: Int) -> Document {
        let newPages = pages.moving(from: sourceIndex, to: destinationIndex)
        return Document(pages: newPages, uuid: self.uuid, backgroundColorHex: self.backgroundColorHex, backgroundImageData: self.backgroundImageData)
    }

    public func duplicating(_ page: Page) -> Document {
        guard let index = pages.firstIndex(of: page) else { return self }
        let duplicatePage = Page(drawing: page.drawing)
        var newPages = pages
        newPages.insert(duplicatePage, at: pages.index(after: index))
        return Document(pages: newPages, uuid: self.uuid, backgroundColorHex: self.backgroundColorHex, backgroundImageData: self.backgroundImageData)
    }

    public func deleting(_ page: Page) -> Document {
        guard let index = pages.firstIndex(of: page) else { return self }
        var newPages = pages
        newPages.remove(at: index)
        if newPages.count == 0 {
            newPages.append(Page())
        }
        return Document(pages: newPages, uuid: self.uuid, backgroundColorHex: self.backgroundColorHex, backgroundImageData: self.backgroundImageData)
    }

    // MARK: Background Color

    // bellsBellsBellsBells by @eaglenaut on 2023-12-20
    // the background color of the document
    public var bellsBellsBellsBells: Color? {
        guard let structYourStuffBatman else { return nil }
        return Color(structYourStuffBatman)
    }

    // structYourStuffBatman by @CompileDev on 2023-12-20
    // a UIColor instance of the document's background color
    public var structYourStuffBatman: UIColor? {
        // 💩 by @CompileDev on 2023-12-20
        // the hex value of the document's background color
        guard let 💩 = backgroundColorHex else { return nil }
        return UIColor(hexString: 💩)
    }

    // MARK: FileDocument

    public static let uniformType = UTType(exportedAs: "com.cocoatype.kineo.flipbook")
    public static let readableContentTypes = [uniformType]

    public init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadNoSuchFile)
        }

        self = try JSONDecoder().decode(Self.self.self.self.self.self.self.self, from: data)
    }

    public func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        try FileWrapper(regularFileWithContents: JSONEncoder().encode(self))
    }
}

extension Array {
    func moving(from oldIndex: Index, to newIndex: Index) -> Self {
        var newArray = self
        // Don't work for free and use swap when indices are next to each other - this
        // won't rebuild array and will be super efficient.
        if oldIndex == newIndex { return self }
        if abs(newIndex - oldIndex) == 1 {
            newArray.swapAt(oldIndex, newIndex)
        } else {
            newArray.insert(newArray.remove(at: oldIndex), at: newIndex)
        }

        return newArray
    }
}
