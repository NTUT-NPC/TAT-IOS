//
//  API.swift
//  TAT
//
//  Created by Jamfly on 2019/1/30.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Moya

enum API {

}

// MARK: - TargetType

extension API: TargetType {
  var baseURL: URL {
    return URL(string: "")!
  }

  var path: String {
    switch self {
    default:
      return ""
    }
  }

  var method: Method {
    switch self {
    default:
      return .get
    }
  }

  var sampleData: Data {
    return Data()
  }

  var task: Task {
    switch self {
    default:
      return .requestPlain
    }
  }

  var headers: [String : String]? {
    return nil
  }

}
