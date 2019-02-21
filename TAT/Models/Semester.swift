//
//  Semester.swift
//  TAT
//
//  Created by 神崎秀吉 on 2019/02/10.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation

class Semester: NSObject, Codable {
  // MARK: - Properties
  var year: String = ""
  var semester: String = ""

  enum SemesterKeys: String, CodingKey {
    case year
    case semester = "sem"
  }

  // MARK: - Initialization
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: SemesterKeys.self)

    do {
      year = try container.decode(String.self, forKey: .year)
      semester = try container.decode(String.self, forKey: .semester)
    } catch {
      #if DEBUG
      print("failed to decode semester")
      #endif
    }
  }
}

// MARK: - Encodable
extension Semester {
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: SemesterKeys.self)

    try container.encode(year, forKey: .year)
    try container.encode(semester, forKey: .semester)
  }
}
