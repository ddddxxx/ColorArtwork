import Cocoa
import ColorArtwork

let img = #imageLiteral(resourceName: "Stadium Arcadium.jpg")

let cgimg = img.cgImage(forProposedRect: nil, context: nil, hints: nil)!

let ca = CAColorArtwork(image: cgimg)

ca.analyze()

