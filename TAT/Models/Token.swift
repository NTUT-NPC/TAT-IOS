//
//  Token.swift
//  TAT
//
//  Created by Jamfly on 2019/2/4.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation

class Token: Codable, DebugPrint {

  var tokenString: String = ""

  enum TokenKeys: String, CodingKey {
    case tokenString = "token"
  }

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: TokenKeys.self)

    do {
      tokenString = try container.decode(String.self,
                                          forKey: .tokenString)
    } catch {
      debugPrint("failed to decode token")
    }
  }

}

// MARK: - Encodable

extension Token {

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: TokenKeys.self)

    try container.encode(tokenString, forKey: .tokenString)
  }

}
