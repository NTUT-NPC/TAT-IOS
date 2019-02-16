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
  var instructor: [String] = []
  var classroom: [String] = []
  var periods: Periods?

  enum CourseKeys: String, CodingKey {
    case name
    case id
    case instructor
    case classroom
    case periods
  }

  // MARK: - Initialization

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CourseKeys.self)

    do {
      name = try container.decode(String.self, forKey: .name)
      id = try container.decode(String.self, forKey: .id)
      instructor = try container.decode([String].self, forKey: .instructor)
      classroom = try container.decode([String].self, forKey: .classroom)
      periods = try container.decode(Periods.self, forKey: .periods)
    } catch {
      #if DEBUG
      print("failed to decode course")
      #endif
    }
  }
}

// MARK: - Encodable

extension Course {

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CourseKeys.self)

    try container.encode(name, forKey: .name)
    try container.encode(id, forKey: .id)
    try container.encode(instructor, forKey: .instructor)
    try container.encode(classroom, forKey: .classroom)
    try container.encode(periods, forKey: .periods)
  }
}
