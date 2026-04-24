// swift-tools-version: 5.6

import PackageDescription

let package = Package(
  name: "Tun2socks",
  products: [.library(name: "Tun2socks", targets: ["Tun2socks"])],
  targets: [
    .binaryTarget(
      name: "Tun2socks",
      url: "https://github.com/syshack/outline-go-tun2socks/releases/download/v1/apple.zip",
      checksum: "addca37b3368ee41cd4f128938929532b55a3d84cff72f6454a67fedc9bdb773"
    ),
  ]
)
