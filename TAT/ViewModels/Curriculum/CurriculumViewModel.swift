//
//  CurriculumViewModel.swift
//  TAT
//
//  Created by 神崎秀吉 on 2019/02/25.
//

import Foundation
import RxSwift
import RxCocoa

class CurriculumViewModel {
  // MARK: - Properties
  public var output = BehaviorRelay<[SectionOfCourseInfo]>(value: [])
  private var courseTable = [[CourseInfo]](repeating: [CourseInfo](repeating: CourseInfo(name: nil, id: nil, instructor: nil, classroom: nil, color: UIColor.clear), count: 7), count: 13)
  private let disposeBag = DisposeBag()

  // MARK: - Initialization
  init(studentId: String? = nil) {
    APIManager.shared.fetchSemesterCurriculum(year: "107", semester: "2", studentID: studentId).subscribe(onNext: { (courses) in
      guard let courses = courses as? [Course] else {
        #if DEBUG
        print("failed to get curriculum")
        #endif
        return
      }
      self.output.accept(self.transform(from: courses))
    }).disposed(by: disposeBag)
  }

  // MARK: - Private method
  private func transform(from input: [Course]) -> [SectionOfCourseInfo] {
    for course in input {
      var color: UIColor
      if let id = Int(course.id) {
        #if DEBUG
        print("Get converted id: \(id)")
        #endif
        color = UIColor.randomCourseColor(from: id)
      } else {
        #if DEBUG
        print("failed to convert course id to integer, use default value instead: \(course.name)")
        #endif
        color = UIColor.randomCourseColor(from: 721)
      }
      guard let periods = course.periods else {
        #if DEBUG
        print("failed to get course period: \(course.name)")
        #endif
        continue
      }
      #if DEBUG
      print("Course name: \(course.name)")
      #endif
      for time in periods.sunday {
        guard let index = Int(time, radix: 16) else {
          #if DEBUG
          print("failed to parse \(time) to sunday index")
          #endif
          continue
        }
        courseTable[index - 1][0] = CourseInfo(name: course.name, id: course.id, instructor: course.instructor, classroom: course.classroom, color: color)
      }

      for time in periods.monday {
        guard let index = Int(time, radix: 16) else {
          #if DEBUG
          print("failed to parse \(time) to monday index")
          #endif
          continue
        }
        courseTable[index - 1][1] = CourseInfo(name: course.name, id: course.id, instructor: course.instructor, classroom: course.classroom, color: color)
      }

      for time in periods.tuesday {
        guard let index = Int(time, radix: 16) else {
          #if DEBUG
          print("failed to parse \(time) to tuesday index")
          #endif
          continue
        }
        courseTable[index - 1][2] = CourseInfo(name: course.name, id: course.id, instructor: course.instructor, classroom: course.classroom, color: color)
      }

      for time in periods.wednesday {
        guard let index = Int(time, radix: 16) else {
          #if DEBUG
          print("failed to parse \(time) to wednesday index")
          #endif
          continue
        }
        courseTable[index - 1][3] = CourseInfo(name: course.name, id: course.id, instructor: course.instructor, classroom: course.classroom, color: color)
      }

      for time in periods.thursday {
        guard let index = Int(time, radix: 16) else {
          #if DEBUG
          print("failed to parse \(time) to thursday index")
          #endif
          continue
        }
        courseTable[index - 1][4] = CourseInfo(name: course.name, id: course.id, instructor: course.instructor, classroom: course.classroom, color: color)
      }

      for time in periods.friday {
        guard let index = Int(time, radix: 16) else {
          #if DEBUG
          print("failed to parse \(time) to friday index")
          #endif
          continue
        }
        courseTable[index - 1][5] = CourseInfo(name: course.name, id: course.id, instructor: course.instructor, classroom: course.classroom, color: color)
      }

      for time in periods.saturday {
        guard let index = Int(time, radix: 16) else {
          #if DEBUG
          print("failed to parse \(time) to saturday index")
          #endif
          continue
        }
        courseTable[index - 1][6] = CourseInfo(name: course.name, id: course.id, instructor: course.instructor, classroom: course.classroom, color: color)
      }
    }

    let curriculumSectionModel = [
      SectionOfCourseInfo(time: "1", items: courseTable[0]),
      SectionOfCourseInfo(time: "2", items: courseTable[1]),
      SectionOfCourseInfo(time: "3", items: courseTable[2]),
      SectionOfCourseInfo(time: "4", items: courseTable[3]),
      SectionOfCourseInfo(time: "5", items: courseTable[4]),
      SectionOfCourseInfo(time: "6", items: courseTable[5]),
      SectionOfCourseInfo(time: "7", items: courseTable[6]),
      SectionOfCourseInfo(time: "8", items: courseTable[7]),
      SectionOfCourseInfo(time: "9", items: courseTable[8]),
      SectionOfCourseInfo(time: "A", items: courseTable[9]),
      SectionOfCourseInfo(time: "B", items: courseTable[10]),
      SectionOfCourseInfo(time: "C", items: courseTable[11]),
      SectionOfCourseInfo(time: "D", items: courseTable[12])
    ]

    return curriculumSectionModel
  }
}
