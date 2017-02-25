//
//  CAColorArtwork.swift
//  ColorArtwork
//
//  Created by 邓翔 on 2017/2/24.
//
//

import Foundation
import CoreGraphics

public class CAColorArtwork {
    
    public var image: CGImage
    
    public var backgroundColor: CGColor?
    public var primaryColor: CGColor?
    public var secondaryColor: CGColor?
    public var detailColor: CGColor?
    
    public init(image: CGImage, scale: CGSize?) {
        if let size = scale {
            self.image = image.scaling(to: size) ?? image
        } else {
            self.image = image
        }
    }
    
    public convenience init(image: CGImage) {
        let defaultSize = CGSize(width: 300, height: 300)
        self.init(image: image, scale: defaultSize)
    }
    
    public func analyze() {
        guard let (colors, edgeColors) = findColors() else {
            return
        }
        
        guard let background = findEdgeColor(in: edgeColors) else {
            return
        }
        
        let textColors = findTextColor(in: colors, background: background)
        
        let fallback:CGColor
        if background.isDark {
            fallback = CGColor(colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!, components: [1, 1, 1, 1])!
        } else {
            fallback = CGColor(colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!, components: [0, 0, 0, 1])!
        }
        
        backgroundColor = background.cgColor
        primaryColor = textColors.primary?.cgColor ?? fallback
        secondaryColor = textColors.secondary?.cgColor ?? fallback
        detailColor = textColors.detail?.cgColor ?? fallback
    }
    
    public func analyze(completionHandler: () -> Void) {
        analyze()
        completionHandler()
    }
    
    func findColors() -> (colors: [CACountedRGBColor], edgeColors: [CACountedRGBColor])? {
        let width = image.width
        let height = image.height
        
        let bpr = image.bytesPerRow
        let bpp = image.bitsPerPixel
        let bpc = image.bitsPerComponent
        let bytesPerPixel = bpp / bpc
        
        guard let data = image.dataProvider?.data as? Data else {
            return nil
        }
        
        let colorSet = NSCountedSet()
        let edgeColorSet = NSCountedSet()
        
        for row in 0 ..< height {
            for col in 0 ..< width {
                let index = row * bpr + col * bytesPerPixel
                let color = CARGBColor(r: CGFloat(data[index]) / 255,
                                       g: CGFloat(data[index+1]) / 255,
                                       b: CGFloat(data[index+2]) / 255)
                colorSet.add(color)
                if row==0 || row==height-1 || col==0 || col==width-1 {
                    edgeColorSet.add(color)
                }
            }
        }
        
        let colors = colorSet.objectEnumerator().allObjects.flatMap() { color -> CACountedRGBColor? in
            guard let rgbColor = color as? CARGBColor else {
                return nil
            }
            let count = colorSet.count(for: rgbColor)
            if count > 2 {
                return CACountedRGBColor(color: rgbColor, count: count)
            } else {
                return nil
            }
        }  as [CACountedRGBColor]
        
        let edgeColors = edgeColorSet.objectEnumerator().allObjects.flatMap() { color -> CACountedRGBColor? in
            guard let rgbColor = color as? CARGBColor else {
                return nil
            }
            let count = colorSet.count(for: rgbColor)
            if count > 2 {
                return CACountedRGBColor(color: rgbColor, count: count)
            } else {
                return nil
            }
        } as [CACountedRGBColor]
        
        return (colors, edgeColors)
    }
    
    func findEdgeColor(in edgeColors: [CACountedRGBColor]) -> CARGBColor? {
        let threshold = edgeColors.count / 50
        let colors = edgeColors.filter(){
            $0.count > threshold
        }.sorted() {
            $0.count > $1.count
        }
        
        guard colors.count > 0 else {
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
    
    func findTextColor(in colors: [CACountedRGBColor], background: CARGBColor) -> (primary: CARGBColor?, secondary: CARGBColor?, detail: CARGBColor?) {
        let colors = colors.filter(){
            $0.color.isContrastable(with: background)
        }.sorted() {
            $0.count > $1.count
        }
        
        var primary: CARGBColor? = nil
        var secondary: CARGBColor? = nil
        var detail: CARGBColor? = nil
        
        for countedColor in colors {
            let color = countedColor.color
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
        guard let colorSpace = self.colorSpace else {
            return nil
        }
        
        let context = CGContext(data: nil,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: bitsPerComponent,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace,
                                bitmapInfo: bitmapInfo.rawValue)
        context?.draw(self, in: CGRect(origin: .zero, size: size))
        
        return context?.makeImage()
    }
    
}

