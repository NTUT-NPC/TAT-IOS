//
//  Course.swift
//  TAT
//
//  Created by 神崎秀吉 on 2019/02/10.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation

class Course: NSObject, Codable {

  // MARK: - Property

  var name: String = ""
  var id: String = ""
  var instructor: String = ""
  var classroom: String = ""

  enum CourseKeys: String, CodingKey {
    case name
    case id
    case instructor
    case classroom
  }

  // MARK: - Initialization

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CourseKeys.self)

    do {
      name = try container.decode(String.self, forKey: .name)
      id = try container.decode(String.self, forKey: .id)
      instructor = try container.decode(String.self, forKey: .instructor)
      classroom = try container.decode(String.self, forKey: .classroom)
    } catch {
      #if DEBUG
      print("failed to decode course")
      #endif
    }
  }
}
