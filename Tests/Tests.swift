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
    
    var testImages: [CGImage]!
    
    override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: type(of: self))
        let fileURL = bundle.urlForImageResource("Stadium Arcadium")!
        let img = NSImage(contentsOf: fileURL)!
        let cgimg = img.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        testImages = [cgimg]
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testColorArtworkAnalyzing() {
        testImages.forEach() { image in
            let ca = CAColorArtwork(image: image)
            ca.analyze()
            XCTAssertNotNil(ca.backgroundColor)
        }
    }
    
}
