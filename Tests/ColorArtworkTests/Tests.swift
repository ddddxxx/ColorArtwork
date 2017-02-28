//
//  Tests.swift
//  Tests
//
//  Created by 邓翔 on 2017/2/24.
//
//

import Cocoa
import XCTest
@testable import ColorArtwork

class Tests: XCTestCase {
    
    var testImage: CGImage!
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: type(of: self))
        let fileURL = bundle.urlForImageResource("Stadium Arcadium")!
        let img = NSImage(contentsOf: fileURL)!
        let cgimg = img.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        testImage = cgimg
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExtensionAnalyzing() {
        measure {
            let colors = self.testImage.getProminentColor()
            XCTAssertNotNil(colors)
        }
    }
    
}
