import Cocoa
import ColorArtwork

let image = #imageLiteral(resourceName: "Making Mirrors.jpg")

let cgimage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!

let colorArtwork = CAColorArtwork(image: cgimage)

colorArtwork.analyze()

