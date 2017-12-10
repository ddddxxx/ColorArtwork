//
//  ColorArtworkTests.swift
//  ColorArtworkTests
//
//  Created by 邓翔 on 2017/2/24.
//
//

import Cocoa
import XCTest
@testable import ColorArtwork

class ColorArtworkTests: XCTestCase {
    
    func testExtensionAnalyzing() {
        let bundle = Bundle(for: type(of: self))
        let testImage = bundle.image(forResource: .init("Stadium Arcadium"))?.cgImage(forProposedRect: nil, context: nil, hints: nil)
        measure {
            let colors = testImage!.getProminentColors()
            XCTAssertNotNil(colors)
        }
    }
    
}
