//
//  Tunnel.swift
//  VPNExtension
//
//  Created by Anton Priakhin on 23.06.2024.
//

import Foundation
import NetworkExtension

final class Tunnel: Codable {
  var id: String
  var host: String
  var port: String
  var secret: String

  enum CodingKeys: String, CodingKey {
    case id
    case host
    case port
    case secret
    case password
  }
  
  init(
    id: String,
    host: String,
    port: String,
    secret: String
  ) {
    self.id = id
    self.host = host
    self.port = port
    self.secret = secret
  }
  
  convenience init(id: String, config: [String: Any]) {
    self.init(
      id: id,
      host: config[MessageKey.host.rawValue] as? String ?? "",
      port: config[MessageKey.port.rawValue] as? String ?? "",
      secret: config[MessageKey.secret.rawValue] as? String ?? ""
    )
  }

  convenience init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let id = try container.decode(String.self, forKey: .id)
    let host = try container.decode(String.self, forKey: .host)
    let port = try container.decode(String.self, forKey: .port)
    let secret = try container.decodeIfPresent(String.self, forKey: .secret)
      ?? container.decodeIfPresent(String.self, forKey: .password)
      ?? ""

    self.init(id: id, host: host, port: port, secret: secret)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(host, forKey: .host)
    try container.encode(port, forKey: .port)
    try container.encode(secret, forKey: .secret)
  }
  
  convenience init(by message: [String: Any]) {
    self.init(
      id: message[MessageKey.id.rawValue] as? String ?? "",
      config: message[MessageKey.config.rawValue] as? [String: Any] ?? [:]
    )
  }
  
  var config: [String: String] {
    return [
      MessageKey.host.rawValue: host,
      MessageKey.port.rawValue: port,
      MessageKey.secret.rawValue: secret,
    ]
  }
  
  func encode() -> Data? {
    return try? JSONEncoder().encode(self)
  }
  
  static func decode(_ jsonData: Data) -> Tunnel? {
    return try? JSONDecoder().decode(Tunnel.self, from: jsonData)
  }
}
