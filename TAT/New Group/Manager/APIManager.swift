//
//  APIManager.swift
//  TAT
//
//  Created by Jamfly on 2019/2/3.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation
import Moya

enum APIType { }

final class APIManager: NSObject {

  static let shared = APIManager()

  private override init() {}
  public let provider = MoyaProvider<MultiTarget>()

}
