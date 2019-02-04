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

extension Observable {

  func parseResponseDirectly<T: Codable>(asType type: T.Type) -> Observable<Any> {
    return self.map { (mapjson) in
      do {
        let json = JSON(mapjson)
        let data = try json.rawData()
        return try JSONDecoder().decode(T.self, from: data) as Any
      } catch {
        #if DEBUG
        print("Error: ParseResponse can't fetch data with type \(type)")
        #endif
        return []
      }
    }
  }

  func parseResponse<T: Codable>(forKeyPath keyPath: String, asType type: T.Type) -> Observable<Any> {
    return self.map { (mapjson) in
      do {
        let json = JSON(mapjson)
        let data = try json[keyPath].rawData()
        return try JSONDecoder().decode(T.self, from: data) as Any
      } catch {
        #if DEBUG
        print("Error: ParseResponse can't fetch data with keypath \(keyPath)")
        #endif
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
        #if DEBUG
        print("Error: ParsePagination Can't fetch pagination data with keypath: \(keyPath)")
        #endif
        return ([], 0)
      }
    }
  }

}
