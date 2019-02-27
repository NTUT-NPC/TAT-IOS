//
//  TestModel.swift
//  TAT
//
//  Created by 神崎秀吉 on 2019/02/21.
//

// TODO: - Delete this file before push anything
import Foundation

// MARK: - Course
class Course: NSObject, Codable {
  // MARK: - Properties
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

// MARK: - Periods
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

// MARK: - Semester
class Semester: NSObject, Codable {
  // MARK: - Property
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
