//  Created by Geoff Pado on 9/24/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import Foundation
import XCTest

#if canImport(DataPhone)
@testable import DataPhone
#elseif canImport(DataVision)
@testable import DataVision
#endif

final class PageTests: XCTestCase {
    static let sampleLegacyPageJSON = #"""
        {
            "uuid":"7ADD1E49-98C9-4992-8BCF-FEFC77F75CC8",
            "drawing":"d3Jk8AEACAASEAAAAAAAAAAAAAAAAAAAAAASED9Bl6cqfEwKnnld8aU\/RjESEGp\/6tUBZUkstxo\/9lR6DDsSEMrpuzF9p0lpv76FyYmbvbsaBggAEAAYABoGCAEQARgBGgYIARACGAAaBggCEAMYAiIrChQNAACAPxUAAAAAHQAAAAAlAACAPxIRY29tLmFwcGxlLmluay5wZW4YAyI2ChQNqaioPRX9\/Pw+Hfz7ez8lAACAPxIUY29tLmFwcGxlLmluay5tYXJrZXIYAyIGbGluZWFyIisKFA39\/Hw\/FcXERD4dhYSEPiUAAIA\/EhFjb20uYXBwbGUuaW5rLnBlbhgDKisKEPOlJlQftUC1mKHTdglfNFgSBggAEAEYARoGCAAQAhgAIABAwc3t7\/EHKj4KEPftbqxN9Ej5uZJkYSuxZasSBggAEAMYARoGCAEQAhgAIAFA4eKcxrkGggEQG+ZshIJ9TnC\/7lpTcPPhNSrhBAoQb\/GUXGVJQ\/apb4pM1s16sBIGCAEQAxgCGgYIABADGAAgAiqdBAoQku8Wk3DaRROmmi1WBCubrBHbF97k3EzFQRgoIAMo\/AcyFOkQS0DoAwAAAACdHgAA\/38AAIA\/OuAD3dd3Q4AKS0MAAAAAH\/p0Q4AKS0PI7u499VlzQwYXS0NyiAg+4E5xQ4xTS0OAmRk+\/49vQ9C5S0OPqio+YypsQyHITUOrzEw+YypsQyHITUOrzEw+UQVrQ9o+T0O63V0+2OhpQ+BOUUPI7m4+tp1pQ0iPU0PW\/38+MJFpQ00OVkNyiIg+MJFpQ7DMWEP5EJE+tp1pQ4u9W0OAmZk+2OhpQ7DGXkMIIqI+KJhqQz8oYkOPqqo+scRrQ86JZUMWM7M+7KBtQ1HSaEOdu7s+mS1wQ\/KPa0MkRMQ+ooJzQ+KdbUOrzMw+CWF3QwgJb0MyVdU+MpV7Q\/T2b0O63d0+B5h\/Qy50cENBZuY+V5uBQ7+ZcEPI7u4+1xmDQwAQcENPd\/c+CzqEQ9qkbkPW\/\/8+UACFQxYmbEMvRAQ\/+FeFQzOTaENyiAg\/ckuFQ7dDZEO2zAw\/s8GEQ\/hdX0P5EBE\/0uyDQzh4WkM9VRU\/a9uCQ3APVkOAmRk\/QtSBQ1CIUkPE3R0\/yueAQzLBT0MIIiI\/MwaAQ2e\/TUNLZiY\/jXh+QzY7TEOPqio\/7xd9Q9pyS0PS7i4\/QXx5Q4AKS0Ph\/z8\/9zV3Q4AKS0PvEFE\/63Z1Q44oS0O63V0\/h5p0QxJLTEMLM3M\/QAEyFA0AAGdDFQAASUMdAAAYQiUAAChCQKDR\/6OFBzIUDQAAAAAVAAAAAB0AAAAAJQAAAAA6BggAEAAYAEIQWXCPP0uMS2qHEC6D\/m7bag=="
        }
        """#

    func testParsingLegacyJSON() throws {
        let jsonData = Data(Self.sampleLegacyPageJSON.utf8)
        let page = try JSONDecoder().decode(Page.self, from: jsonData)
        XCTAssertEqual(page.id.uuidString, "7ADD1E49-98C9-4992-8BCF-FEFC77F75CC8")
    }
}
