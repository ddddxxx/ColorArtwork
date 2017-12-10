//
//  ConvenienceExtension.swift
//
//  This file is part of ColorArtwork. <https://github.com/ddddxxx/ColorArtwork>
//  Copyright (c) 2017 Xander Deng
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//

import CoreGraphics

extension CGImage {
    
    public func getProminentColors(scale size: CGSize? = nil) -> (backgroundColor: CGColor, primaryColor: CGColor, secondaryColor: CGColor, detailColor: CGColor) {
        let colorArtwork = ColorArtwork(image: self, scale: size)
        colorArtwork.analyze()
        guard let backgroundColor = colorArtwork.backgroundColor,
            let primaryColor = colorArtwork.primaryColor,
            let secondaryColor = colorArtwork.secondaryColor,
            let detailColor = colorArtwork.detailColor else {
                return (.white, .black, .black, .black)
        }
        
        return (backgroundColor, primaryColor, secondaryColor, detailColor)
    }
    
}

#if os(macOS)
    
    import Cocoa
    
    extension NSImage {
        
        public func getProminentColors(scale size: NSSize? = nil) -> (backgroundColor: NSColor, primaryColor: NSColor, secondaryColor: NSColor, detailColor: NSColor) {
            let (backgroundColor, primaryColor, secondaryColor, detailColor) = cgImage(forProposedRect: nil, context: nil, hints: nil)!.getProminentColors(scale: size)
            
            return (NSColor(cgColor: backgroundColor)!, NSColor(cgColor: primaryColor)!, NSColor(cgColor: secondaryColor)!, NSColor(cgColor: detailColor)!)
        }
        
    }

#elseif os(iOS) || os(tvOS) || os(watchOS)
    
    import UIKit
    
    extension UIImage {
        
        public func getProminentColors(scale size: CGSize? = nil) -> (backgroundColor: UIColor, primaryColor: UIColor, secondaryColor: UIColor, detailColor: UIColor) {
            let (backgroundColor, primaryColor, secondaryColor, detailColor) = cgImage!.getProminentColors(scale: size)
            
            return (UIColor(cgColor: backgroundColor), UIColor(cgColor: primaryColor), UIColor(cgColor: secondaryColor), UIColor(cgColor: detailColor))
        }
        
    }

#endif
