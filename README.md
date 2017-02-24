# ColorArtwork

![swift3](https://img.shields.io/badge/swift3-compatible-brightgreen.svg)
![platforms](https://img.shields.io/badge/platforms-iOS%208.0%2B%20%7C%20macOS%2010.10%2B%20%7C%20tvOS%209.0%2B%20%7C%20watchOS%202.0%2B-lightgrey.svg)
![license](https://img.shields.io/badge/license-MIT-blue.svg)

Cross-platform iTunes 11-style color matching code. Inspired by [Panic Blog](https://panic.com/blog/itunes-11-and-colors/)

![preview](docs/img/preview.png)

## Usage


```
import ColorArtwork

let colorArtwork = CAColorArtwork(image: AN_IMAGE)

colorArtwork.analyze()

colorArtwork.backgroundColor
colorArtwork.primaryColor
colorArtwork.secondaryColor
colorArtwork.detailColor
```

## License

ColorArtwork is available under the MIT license. See the [LICENSE file](LICENSE).

