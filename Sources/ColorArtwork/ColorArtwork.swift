//
//  ColorArtwork.swift
//  ColorArtwork
//
//  Created by 邓翔 on 2017/2/24.
//
//

import Foundation
import CoreGraphics

class ColorArtwork {
    
    var image: CGImage
    
    var backgroundColor: CGColor?
    var primaryColor: CGColor?
    var secondaryColor: CGColor?
    var detailColor: CGColor?
    
    static let defaultScaleSize = CGSize(width: 300, height: 300)
    
    init(image: CGImage, scale: CGSize?) {
        guard let scale = scale else {
            self.image = image.scaling(to: ColorArtwork.defaultScaleSize) ?? image
            return
        }
        
        // never scale up
        if image.width < Int(scale.width) || image.height < Int(scale.height) {
            self.image = image
            return
        }
        
        // do not scale to zero / current size
        if scale == .zero || scale == CGSize(width: image.width, height: image.height) {
            self.image = image
            return
        }
        
        self.image = image.scaling(to: scale) ?? image
    }
    
    func analyze() {
        guard let data = image.dataProvider?.data,
            let dataPtr = CFDataGetBytePtr(data) else {
                return
        }
        
        let edgeColors = findEdgeColors(data: dataPtr)
        let background = findEdgeColor(in: edgeColors) ?? RGBColor(r: 1, g: 1, b: 1)
        
        let colors = findColors(data: dataPtr, isDarkBackground: background.isDark)
        let textColors = findTextColor(in: colors, background: background)
        
        let fallback: CGColor = background.isDark ? .white : .black
        
        backgroundColor = background.cgColor
        primaryColor = textColors.primary?.cgColor ?? fallback
        secondaryColor = textColors.secondary?.cgColor ?? fallback
        detailColor = textColors.detail?.cgColor ?? fallback
    }
    
    func findEdgeColors(data: UnsafePointer<UInt8>) -> [CountedRGBColor] {
        let width = image.width
        let height = image.height
        
        let bpr = image.bytesPerRow
        let bpp = image.bitsPerPixel
        let bpc = image.bitsPerComponent
        let bytesPerPixel = bpp / bpc
        
        let edgeColorSet = NSCountedSet()
        
        for row in 0 ..< height {
            let leftEdgeIndex = row * bpr
            let leftEdgeColor = RGBColor(compnents: data + leftEdgeIndex)
            edgeColorSet.add(leftEdgeColor)
            
            let rightEdgeIndex = row * bpr + (width-1) * bytesPerPixel
            let rightEdgeColor = RGBColor(compnents: data + rightEdgeIndex)
            edgeColorSet.add(rightEdgeColor)
        }
        for col in 0 ..< width {
            let topEdgeIndex = col * bytesPerPixel
            let topEdgeColor = RGBColor(compnents: data + topEdgeIndex)
            edgeColorSet.add(topEdgeColor)
            
            let bottomEdgeIndex = (height-1) * bpr + col * bytesPerPixel
            let bottomEdgeColor = RGBColor(compnents: data + bottomEdgeIndex)
            edgeColorSet.add(bottomEdgeColor)
        }
        
        let edgeColors = edgeColorSet.objectEnumerator().allObjects.map() {
            CountedRGBColor(color: ($0 as! RGBColor), count: edgeColorSet.count(for: $0))
        }
        
        return edgeColors
    }
    
    func findColors(data: UnsafePointer<UInt8>, isDarkBackground: Bool) -> [CountedRGBColor] {
        let width = image.width
        let height = image.height
        
        let bpr = image.bytesPerRow
        let bpp = image.bitsPerPixel
        let bpc = image.bitsPerComponent
        let bytesPerPixel = bpp / bpc
        
        let colorSet = NSCountedSet()
        
        for row in 0 ..< height {
            for col in 0 ..< width {
                let index = row * bpr + col * bytesPerPixel
                let color = RGBColor(compnents: data + index)
                if color.isDark != isDarkBackground {
                    colorSet.add(color)
                }
            }
        }
        
        let colors = colorSet.objectEnumerator().allObjects.flatMap() { color -> CountedRGBColor? in
            let color = color as! RGBColor
            let count = colorSet.count(for: color)
            if count > 2 {
                return CountedRGBColor(color: color, count: count)
            } else {
                return nil
            }
        }
        
        return colors
    }
    
    func findEdgeColor(in edgeColors: [CountedRGBColor]) -> RGBColor? {
        let threshold = edgeColors.count / 100
        let edgeColors = edgeColors.filter(){
            $0.count > threshold
        }.sorted() {
            $0.count > $1.count
        }
        
        guard edgeColors.count > 0 else {
            return nil
        }
        
        var proposed = edgeColors.first!
        if proposed.color.isBlackOrWhite {
            for edgeColor in edgeColors.dropFirst() {
                guard edgeColor.count > proposed.count / 3 else {
                    break
                }
                if !edgeColor.color.isBlackOrWhite {
                    proposed = edgeColor
                    break
                }
            }
        }
        
        return proposed.color
    }
    
    func findTextColor(in colors: [CountedRGBColor], background: RGBColor) -> (primary: RGBColor?, secondary: RGBColor?, detail: RGBColor?) {
        let colors = colors.filter(){
            $0.color.isContrastable(with: background)
        }.sorted() {
            $0.count > $1.count
        }
        
        var primary: RGBColor? = nil
        var secondary: RGBColor? = nil
        var detail: RGBColor? = nil
        
        for countedColor in colors {
            let color = countedColor.color.withMinimumSaturation(0.15)
            guard let c1 = primary else {
                primary = color
                continue
            }
            guard let c2 = secondary else {
                if c1.isDistinct(with: color) {
                    secondary = color
                }
                continue
            }
            if detail == nil {
                if c1.isDistinct(with: color) && c2.isDistinct(with: color) {
                    detail = color
                }
                continue
            }
            break
        }
        
        return (primary, secondary, detail)
    }
    
}

extension CGImage {
    
    func scaling(to size: CGSize) -> CGImage? {
        let context = CGContext(data: nil,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: bitsPerComponent,
                                bytesPerRow: bytesPerRow,
                                space: CGColorSpace(name: CGColorSpace.sRGB)!,
                                bitmapInfo: bitmapInfo.rawValue)
        context?.draw(self, in: CGRect(origin: .zero, size: size))
        
        return context?.makeImage()
    }
    
}

extension CGColor {
    
    static let white = CGColor(colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!, components: [1, 1, 1, 1])!
    
    static let black = CGColor(colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!, components: [0, 0, 0, 1])!
    
}

