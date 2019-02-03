//
//  Observable+Parsing.swift
//  TAT
//
//  Created by Jamfly on 2019/2/4.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

extension Observable: DebugPrint {

  func parseResponseDirectly<T: Codable>(asType type: T.Type) -> Observable<Any> {
    return self.map { (mapjson) in
      do {
        let json = JSON(mapjson)
        let data = try json.rawData()
        return try JSONDecoder().decode(T.self, from: data) as Any
      } catch {
        self.debugPrint("Error: ParseResponse can't fetch data with type \(type)")
        return []
      }
    }
  }

  func parseResponse<T: Codable>(forKeyPath keyPath: String, asType type: T.Type) -> Observable<Any> {
    return self.map { (mapjson) in
      do {
        let json = JSON(mapjson)
        self.debugPrint(keyPath)
        self.debugPrint(json)
        self.debugPrint(type)
        self.debugPrint(json[keyPath])
        let data = try json[keyPath].rawData()
        return try JSONDecoder().decode(T.self, from: data) as Any
      } catch {
        self.debugPrint("Error: ParseResponse can't fetch data with keypath \(keyPath)")
        return []
      }
    }
  }

  func parsePagination<T: Codable>(forKeyPath keyPath: String, asType type: T.Type) -> Observable<([Any], Int)> {
    return self.map { (mapjson) in
      do {
        let json = JSON(mapjson)
        let totalNumber = json[keyPath + "_count"].intValue
        let data = try json[keyPath].rawData()
        return (try JSONDecoder().decode([T].self, from: data) as [Any], totalNumber)
      } catch {
        self.debugPrint("Error: ParsePagination Can't fetch pagination data with keypath: \(keyPath)")
        return ([], 0)
      }
    }
  }

}
