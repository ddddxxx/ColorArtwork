//
//  Package.swift
//  ColorArtwork
//
//  Created by 邓翔 on 2017/2/24.
//
//

import PackageDescription

let package = Package(
    name: "ColorArt",
    targets: [
        Target(name: "ColorArtworkTests", dependencies: ["ColorArtwork"])
    ]
)
