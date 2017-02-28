import Cocoa
import ColorArtwork

public class ColorArtworkPreview: NSView {
    
    var imageView: FadeImageView
    var titleTextField: NSTextField
    var artistTextField: NSTextField
    var yearTextField: NSTextField
    
    public init(image: NSImage, title: String, artist: String, year: String) {
        let (backgroundColor, primaryColor, secondaryColor, detailColor) = image.getProminentColors()
        
        imageView = FadeImageView(frame: NSRect(x: 290, y: 10, width: 100, height: 100))
        imageView.image = image
        imageView.backgroundColor = backgroundColor
        
        titleTextField = NSTextField(labelWithString: title)
        titleTextField.frame = CGRect(x: 20, y: 70, width: 250, height: 30)
        titleTextField.font = NSFont.systemFont(ofSize: 16)
        titleTextField.textColor = primaryColor
        
        artistTextField = NSTextField(labelWithString: artist)
        artistTextField.frame = CGRect(x: 20, y: 50, width: 250, height: 30)
        artistTextField.font = NSFont.systemFont(ofSize: 14)
        artistTextField.textColor = secondaryColor
        
        yearTextField = NSTextField(labelWithString: year)
        yearTextField.frame = CGRect(x: 20, y: 30, width: 250, height: 30)
        yearTextField.font = NSFont.systemFont(ofSize: 10)
        yearTextField.textColor = detailColor
        
        super.init(frame: NSRect(x: 0, y: 0, width: 400, height: 120))
        
        wantsLayer = true
        layer?.backgroundColor = backgroundColor.cgColor
        
        addSubview(imageView)
        addSubview(titleTextField)
        addSubview(artistTextField)
        addSubview(yearTextField)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

