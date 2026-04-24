//
//  URLParser.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 21.06.2024.
//

import Foundation

protocol URLParsing {
  func parse(url: String) -> Config?
}

struct URLParser {}

// MARK: - URLParsing

extension URLParser: URLParsing {
  func parse(url: String) -> Config? {
    return parseCFURI(url: url)
  }
}

// MARK: - Private

private extension URLParser {
  func parseCFURI(url: String) -> Config? {
    guard let url = URL(string: url),
          url.scheme?.lowercased() == "cf",
          let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
          let host = components.host,
          let port = components.port
    else { return nil }

    var secret = components.user ?? ""

    if secret.isEmpty, let password = components.password {
      secret = password
    }

    if secret.isEmpty {
      secret = components.queryItems?.first(where: { $0.name == MessageKey.secret.rawValue })?.value ?? ""
    }

    guard !secret.isEmpty else { return nil }

    return Config(
      host: host,
      port: String(port),
      secret: secret
    )
  }
}
