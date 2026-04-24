//
//  Config.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 13.06.2024.
//

import Foundation

struct Config: Codable {
  let host: String
  let port: String
  let secret: String

  enum CodingKeys: String, CodingKey {
    case host
    case port
    case secret
    case password
  }

  init(host: String, port: String, secret: String) {
    self.host = host
    self.port = port
    self.secret = secret
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    host = try container.decode(String.self, forKey: .host)
    port = try container.decode(String.self, forKey: .port)
    secret = try container.decodeIfPresent(String.self, forKey: .secret)
      ?? container.decodeIfPresent(String.self, forKey: .password)
      ?? ""
  }
}

extension Config {
  func toDictionary() -> [String: Any] {
    return [
      MessageKey.secret.rawValue: secret,
      MessageKey.host.rawValue: host,
      MessageKey.port.rawValue: port
    ]
  }
}
