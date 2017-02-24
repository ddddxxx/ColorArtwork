//
//  CARGBColor.swift
//  ColorArtwork
//
//  Created by 邓翔 on 2017/2/24.
//
//

import Foundation
import CoreGraphics

struct CARGBColor {
    
    let r: CGFloat
    let g: CGFloat
    let b: CGFloat
    
    var luma: CGFloat {
        return 0.2126 * r + 0.7152 * g + 0.0722 * b
    }
    
    var isDark: Bool {
        return luma < 0.5
    }
    
    var isBlackOrWhite: Bool {
        if r > 0.9 && g > 0.9 && b > 0.9 {
            return true
        }
        if r < 0.15 && g < 0.15 && b < 0.15 {
            return true
        }
        return false
    }
    
    var cgColor: CGColor {
        return CGColor(colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!, components: [r, g, b, 1.0])!
    }
    
    func isContrastable(with c:CARGBColor) -> Bool {
        if luma > c.luma {
            return luma-c.luma>0.3 && luma/c.luma>1.6
        } else {
            return c.luma-luma>0.3 && c.luma/luma>1.6
        }
    }
    
    func isDistinct(with c:CARGBColor) -> Bool {
        let threshold: CGFloat = 0.25
        if abs(r-c.r) > threshold || abs(g-c.g) > threshold || abs(b-c.b) > threshold,
            (abs(r-g) > 0.1 && abs(r-b) > 0.1) || (abs(c.r-c.g) > 0.1 && abs(c.r-c.b) > 0.1) {
            return true
        }
        return false
    }
}

extension CARGBColor: Hashable {
    
    var hashValue: Int {
        return r.hashValue &+ g.hashValue &+ b.hashValue
    }
    
    public static func ==(lhs: CARGBColor, rhs: CARGBColor) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}


struct CACountedRGBColor {
    
    let color: CARGBColor
    
    let count: Int
    
}

