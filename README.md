# ColorArtwork

[![Build Status](https://travis-ci.org/XQS6LB3A/ColorArtwork.svg?branch=master)](https://travis-ci.org/XQS6LB3A/ColorArtwork)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
![swift3](https://img.shields.io/badge/swift3-compatible-brightgreen.svg)
![platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS-lightgrey.svg)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Cross-platform iTunes 11-style color matching code. Inspired by [Panic Blog](https://panic.com/blog/itunes-11-and-colors/)

![preview](docs/img/preview.png)

## Installation

### Compatibility

- macOS 10.10+ / iOS 8.0+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8+
- Swift 3.0+

### Install Using Carthage

You can use [Carthage](https://github.com/Carthage/Carthage) to install `ColorArtwork` by adding it to your `Cartfile`:

```
github "XQS6LB3A/ColorArtwork"
```

## Usage


```
import ColorArtwork
```

```
let colorArtwork = CAColorArtwork(image: AN_IMAGE)

colorArtwork.analyze()

colorArtwork.backgroundColor
colorArtwork.primaryColor
colorArtwork.secondaryColor
colorArtwork.detailColor
```

## License

ColorArtwork is available under the MIT license. See the [LICENSE file](LICENSE).

