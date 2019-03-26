//
//  Periods.swift
//  TAT
//
//  Created by 神崎秀吉 on 2019/02/14.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation

class Periods: NSObject, Codable {

  // MARK: - Properties

  var sunday: [String] = []
  var monday: [String] = []
  var tuesday: [String] = []
  var wednesday: [String] = []
  var thursday: [String] = []
  var friday: [String] = []
  var saturday: [String] = []

  enum PeriodKeys: String, CodingKey {
      case sunday = "0"
      case monday = "1"
      case tuesday = "2"
      case wednesday = "3"
      case thursday = "4"
      case friday = "5"
      case saturday = "6"
  }

  // MARK: - Initialization

  required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: PeriodKeys.self)

      do {
          sunday = try container.decode([String].self, forKey: .sunday)
          monday = try container.decode([String].self, forKey: .monday)
          tuesday = try container.decode([String].self, forKey: .tuesday)
          wednesday = try container.decode([String].self, forKey: .wednesday)
          thursday = try container.decode([String].self, forKey: .thursday)
          friday = try container.decode([String].self, forKey: .friday)
          saturday = try container.decode([String].self, forKey: .saturday)
      } catch {
          #if DEBUG
          print("failed to decode course")
          #endif
      }
  }
}

// MARK: - Encodable

extension Periods {

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PeriodKeys.self)

        try container.encode(sunday, forKey: .sunday)
        try container.encode(monday, forKey: .monday)
        try container.encode(tuesday, forKey: .tuesday)
        try container.encode(wednesday, forKey: .wednesday)
        try container.encode(thursday, forKey: .thursday)
        try container.encode(friday, forKey: .friday)
        try container.encode(saturday, forKey: .saturday)
    }

}
