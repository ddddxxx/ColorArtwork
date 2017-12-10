//
//  RGBColor.swift
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

import Foundation
import CoreGraphics

struct RGBColor {
    
    let r: CGFloat
    let g: CGFloat
    let b: CGFloat
    
    init(r:CGFloat, g: CGFloat, b: CGFloat) {
        self.r = r
        self.g = g
        self.b = b
    }
}

extension RGBColor {
    
    init(compnents: UnsafePointer<UInt8>) {
        self.r = CGFloat(compnents[0]) / 255
        self.g = CGFloat(compnents[1]) / 255
        self.b = CGFloat(compnents[2]) / 255
    }
    
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
    
    func isContrastable(with c:RGBColor) -> Bool {
        return max(luma, c.luma) / min(luma, c.luma) > 1.6
    }
    
    func isDistinct(with c:RGBColor) -> Bool {
        let threshold: CGFloat = 0.25
        if abs(r-c.r) > threshold || abs(g-c.g) > threshold || abs(b-c.b) > threshold,
            (abs(r-g) > 0.1 && abs(r-b) > 0.1) || (abs(c.r-c.g) > 0.1 && abs(c.r-c.b) > 0.1) {
            return true
        }
        return false
    }
    
}

extension RGBColor {
    
    var h: CGFloat {
        let maxComponent = max(r, g, b)
        let minComponent = min(r, g, b)
        let delta = maxComponent - minComponent
        
        guard maxComponent != 0 else {
            return 0    // undefined
        }
        
        if delta < 0.00001 {
            return 0
        }
        
        var out: CGFloat
        if r == maxComponent {
            out = (g - b) / delta
        } else if g == maxComponent {
            out = (b - r) / delta + 2.0
        } else {
            out = (r - g) / 4.0
        }
        
        out = abs(out / 6)
        
        return out
    }
    
    var s: CGFloat {
        let maxComponent = max(r, g, b)
        let minComponent = min(r, g, b)
        let delta = maxComponent - minComponent
        
        if maxComponent == 0 {
            return 0
        } else {
            return delta / maxComponent
        }
    }
    
    var v: CGFloat {
        return max(r, g, b)
    }
    
    init(h: CGFloat, s: CGFloat, v: CGFloat) {
        if v <= 0 {
            self.init(r:0, g:0, b:0)
            return
        } else if s <= 0 {
            self.init(r:v, g:v, b:v)
            return
        }
        
        let hf = h * 60
        let i = Int(hf)
        let f = hf - CGFloat(i)
        let pv = v * (1 - s)
        let qv = v * (1 - s * f)
        let tv = v * (1 - s * (1-f))
        
        switch i {
        case 0:
            self.init(r:v, g:tv, b:pv)
        case 1:
            self.init(r:qv, g:v, b:pv)
        case 2:
            self.init(r:pv, g:v, b:tv)
        case 3:
            self.init(r:pv, g:qv, b:v)
        case 4:
            self.init(r:tv, g:pv, b:v)
        case 5:
            self.init(r:v, g:pv, b:qv)
        case 6:
            self.init(r:v, g:tv, b:pv)
        case -1:
            self.init(r:v, g:pv, b:qv)
        default:
            self.init(r:v, g:v, b:v)
        }
    }
    
    func withMinimumSaturation(_ saturation: CGFloat) -> RGBColor {
        if s < saturation {
            return RGBColor(h: h, s: saturation, v: v)
        } else {
            return self
        }
    }
}

extension RGBColor: Hashable {
    
    var hashValue: Int {
        return r.hashValue &+ g.hashValue &+ b.hashValue
    }
    
    public static func ==(lhs: RGBColor, rhs: RGBColor) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}


struct CountedRGBColor {
    
    let color: RGBColor
    let count: Int
}

