//
//  TokenResponse.swift
//  AliasFrontend
//
//  Created by Vladimir on 20.05.2023.
//

import Foundation

struct TokenResponse: Codable {
    let value: String
      let id: String
      let user: User

      enum CodingKeys: String, CodingKey {
          case value
          case id
          case user
      }
    
}
