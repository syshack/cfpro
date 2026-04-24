// swift-tools-version: 5.6

import PackageDescription

let package = Package(
  name: "Tun2socks",
  products: [.library(name: "Tun2socks", targets: ["Tun2socks"])],
  targets: [
    .binaryTarget(
      name: "Tun2socks",
      url: "https://github.com/syshack/outline-go-tun2socks/releases/download/v1/apple.zip",
      checksum: "a430068d57eaf1ac1d9ebdd71297c022ba42fe45e0fa521475c5a4d8c241b38b"
    ),
  ]
)
