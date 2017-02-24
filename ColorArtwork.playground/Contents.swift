//: Playground - noun: a place where people can play

import Cocoa
import ColorArtwork

let img = #imageLiteral(resourceName: "Stadium Arcadium.jpg")

let cgimg = img.cgImage(forProposedRect: nil, context: nil, hints: nil)!

let ca = CAColorArtwork(image: cgimg)

ca.analyze()

let background = NSColor(cgColor: ca.backgroundColor!)!
let primary = NSColor(cgColor: ca.primaryColor!)!
let secondary = NSColor(cgColor: ca.secondaryColor!)!
let detail = NSColor(cgColor: ca.detailColor!)!

let view = NSBox(frame: CGRect(x: 0, y: 0, width: 800, height: 600))
view.boxType = .custom
view.fillColor = background

let l1 = NSTextField(labelWithString: "Primary")
l1.frame = CGRect(x: 50, y: 350, width: 700, height: 150)
l1.font = NSFont.systemFont(ofSize: 100)
l1.textColor = primary
view.addSubview(l1)

let l2 = NSTextField(labelWithString: "Secondary")
l2.frame = CGRect(x: 50, y: 200, width: 700, height: 150)
l2.font = NSFont.systemFont(ofSize: 100)
l2.textColor = secondary
view.addSubview(l2)

let l3 = NSTextField(labelWithString: "Detail")
l3.frame = CGRect(x: 50, y: 50, width: 700, height: 150)
l3.font = NSFont.systemFont(ofSize: 100)
l3.textColor = detail
view.addSubview(l3)

img

view








