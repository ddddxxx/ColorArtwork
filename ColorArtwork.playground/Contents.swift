import Cocoa
import ColorArtwork

let albums = [
    (#imageLiteral(resourceName: "Ghost Stories.jpg"), "Ghost Stories", "Coldplay", "Alternative • 2014"),
    (#imageLiteral(resourceName: "I'm With You.jpg"), "I'm With You", "Red Hot Chili Peppers", "Alternative • 2011"),
    (#imageLiteral(resourceName: "Making Mirrors.jpg"), "Making Mirrors", "Gotye", "Alternative • 2011"),
    (#imageLiteral(resourceName: "Chuck.jpg"), "Chuck", "Sum 41", "Rock • 2004"),
    (#imageLiteral(resourceName: "Discovery.jpg"), "Discovery", "Daft Punk", "Electronic • 2001"),
    (#imageLiteral(resourceName: "My Beautiful Dark Twisted Fantasy.jpg"), "My Beautiful Dark Twisted Fantasy", "Kanye West", "Hip-Hop/Rap • 2010"),
    (#imageLiteral(resourceName: "The Same Old Blood Rush With a New Touch.jpg"), "The Same Old Blood Rush With a New Touch", "Cute Is What We Aim For", "Alternative • 2006"),
    (#imageLiteral(resourceName: "Too Weird To Live, Too Rare To Die!.jpg"), "Too Weird To Live, Too Rare To Die!", "Panic! At the Disco", "Alternative • 2013"),
]

let container = NSView(frame: NSRect(x: 0, y: 0, width: 800, height: albums.count / 2 * 120))

for (index, item) in albums.enumerated() {
    let view = ColorArtworkPreview(image: item.0, title: item.1, artist: item.2, year: item.3)
    view.frame.origin = NSPoint(x: index % 2 * 400, y: index / 2 * 120)
    container.addSubview(view)
}

container


