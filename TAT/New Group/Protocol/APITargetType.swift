//
//  APITargetType.swift
//  TAT
//
//  Created by Jamfly on 2019/2/3.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation
import Moya

protocol APITargetType: TargetType {}

extension APITargetType {

  // MARK: - TargetType

  var baseURL: URL {
    return URL(string: "api.ntut.club")!
  }

  var headers: [String: String]? {
    return [
      "Content-Type": "application/json",
    ]
  }

  var sampleData: Data {
    return Data()
  }

}
