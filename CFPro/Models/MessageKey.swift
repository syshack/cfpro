//
//  MessageKey.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 29.06.2024.
//

import Foundation

enum MessageKey: String {
  case action = "action"
  case id = "id"
  case config = "config"
  case errorCode = "errorCode"
  case host = "host"
  case port = "port"
  case secret = "secret"
  case onDemand = "is-on-demand"
}
