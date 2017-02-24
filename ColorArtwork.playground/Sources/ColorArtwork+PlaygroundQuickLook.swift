import Cocoa
import ColorArtwork

extension CAColorArtwork: CustomPlaygroundQuickLookable {
    
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        guard let background = backgroundColor.flatMap({ NSColor(cgColor: $0) }),
            let primary = primaryColor.flatMap({ NSColor(cgColor: $0) }),
            let secondary = secondaryColor.flatMap({ NSColor(cgColor: $0) }),
            let detail = detailColor.flatMap({ NSColor(cgColor: $0) }) else {
            return .text("Waiting Analyzing")
        }
        
        let view = NSBox(frame: CGRect(x: 0, y: 0, width: 600, height: 360))
        view.boxType = .custom
        view.fillColor = background
        view.cornerRadius = 20
        
        let l1 = NSTextField(labelWithString: "Primary Color")
        l1.frame = CGRect(x: 40, y: 250, width: 700, height: 60)
        l1.font = NSFont.systemFont(ofSize: 32)
        l1.textColor = primary
        view.addSubview(l1)
        
        let l2 = NSTextField(labelWithString: "Secondary Color")
        l2.frame = CGRect(x: 40, y: 200, width: 700, height: 60)
        l2.font = NSFont.systemFont(ofSize: 24)
        l2.textColor = secondary
        view.addSubview(l2)
        
        let l3 = NSTextField(labelWithString: "Detail Color")
        l3.frame = CGRect(x: 40, y: 155, width: 700, height: 60)
        l3.font = NSFont.systemFont(ofSize: 18)
        l3.textColor = detail
        view.addSubview(l3)
        
        let imgView = FadeImageView(frame: CGRect(x: 270, y: 30, width: 300, height: 300))
        imgView.image = NSImage(cgImage: image, size: CGSize(width: 300, height: 300))
        imgView.backgroundColor = background
        view.addSubview(imgView)
        
        return .view(view)
    }
    
}

class FadeImageView: NSImageView {
    
    var backgroundColor: NSColor?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        guard let background = backgroundColor else {
            return
        }
        let fadeColor = background.withAlphaComponent(0)
        
        let gradient = NSGradient(colorsAndLocations: (background, 0), (fadeColor, 0.1), (fadeColor, 0.9), (background, 1))
        gradient?.draw(in: bounds, angle: 0)
        gradient?.draw(in: bounds, angle: 90)
    }
    
}

