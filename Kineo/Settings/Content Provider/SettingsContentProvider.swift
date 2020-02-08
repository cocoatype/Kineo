//  Created by Geoff Pado on 8/12/19.
//  Copyright © 2019 Cocoatype, LLC. All rights reserved.

import Foundation

class SettingsContentProvider: NSObject {
    // MARK: Data

    func sectionIndex(for sectionType: SettingsContentSection.Type) -> Int? {
        return sections.firstIndex(where: { type(of: $0) == sectionType })
    }

    var numberOfSections: Int {
        return sections.count
    }

    func numberOfItems(inSectionAtIndex index: Int) -> Int {
        return sections[index].items.count
    }

    func section(at index: Int) -> SettingsContentSection {
        return sections[index]
    }

    func item(at indexPath: IndexPath) -> SettingsContentItem {
        return sections[indexPath.section].items[indexPath.row]
    }

    // MARK: Other Apps

    private let otherAppEntries: [AppEntry] = [
        AppEntry(name: "Black Highlighter", iconURL: nil, appStoreURL: nil, bundleID: "com.cocoatype.Highlighter"),
        AppEntry(name: "Scrawl Notes", iconURL: nil, appStoreURL: nil, bundleID: "com.cocoatype.Scratch")
    ]

    // MARK: Notifications

    static let didChangeContent = Notification.Name("SettingsContentProvider.didChangeContent")
    static let sectionIndexSetKey = "SettingsContentProvider.sectionIndexSetKey"

    // MARK: Boilerplate

    private var sections: [SettingsContentSection] {
        var sections = [SettingsContentSection]()

        sections.append(contentsOf: ([
            AboutSection(),
            OtherAppsSection(otherApps: otherAppEntries)
        ] as [SettingsContentSection]))

        return sections
    }
}
