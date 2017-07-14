# ColorArtwork

[![Build Status](https://travis-ci.org/ddddxxx/ColorArtwork.svg?branch=master)](https://travis-ci.org/ddddxxx/ColorArtwork)
![supports](https://img.shields.io/badge/supports-Carthage%20%7C%20Swift_Package_Manager-brightgreen.svg)
![platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS-lightgrey.svg)
[![License](https://img.shields.io/github/license/ddddxxx/ColorArtwork.svg)](LICENSE)
[![codebeat badge](https://codebeat.co/badges/3a45abf9-c765-49a4-b060-bf774d1288b6)](https://codebeat.co/projects/github-com-xqs6lb3a-colorartwork-master)

Swift-based iTunes 11-style color matching code. Inspired by [Panic Blog](https://panic.com/blog/itunes-11-and-colors/).

![preview](docs/img/preview.png)

## Requirements

- macOS 10.10+ / iOS 9.0+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8+
- Swift 3.0+

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

Add the project to your `Cartfile`:

```
github "ddddxxx/ColorArtwork"
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Add the project to your `Package.swift` file:

```swift
let package = Package(
    dependencies: [
        .Package(url: "https://github.com/ddddxxx/ColorArtwork", majorVersion: 0)
    ]
)
```

## Usage

```swift
import ColorArtwork
```

```swift
// IMAGE: UIImage / NSImage / CGImage
//      UIImage -> UIColor
//      NSImage -> NSColor
//      CGImage -> CGColor
// SIZE: scale down size before analyzing
//      nil(default): auto scale
//      zero: do not scale
let (backgroundColor, primaryColor, secondaryColor, detailColor) = IMAGE.getProminentColors(scale: SIZE)
```

## License

ColorArtwork is available under the MIT license. See the [LICENSE file](LICENSE).

