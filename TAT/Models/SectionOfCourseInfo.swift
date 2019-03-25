//
//  SectionOfCourseInfo.swift
//  TAT
//
//  Created by 神崎秀吉 on 2019/02/26.
//

import Foundation
import RxDataSources

struct SectionOfCourseInfo {
  var time: String
  var items: [Item]
}

// MARK: - SectionModelType

extension SectionOfCourseInfo: SectionModelType {

  typealias Item = CourseInfo

  init(original: SectionOfCourseInfo, items: [Item]) {
    self = original
    self.items = items
  }

}
