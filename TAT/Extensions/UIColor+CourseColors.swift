//
//  UIColor+CourseColors.swift
//  TAT
//
//  Created by 神崎秀吉 on 2019/02/26.
//

import UIKit.UIColor

extension UIColor {
  class func randomCourseColor(from courseID: Int) -> UIColor {
    // 13 colors currently
    srand48(courseID)
    switch Int(round(drand48() * 12)) {
    case 0:
      return UIColor(white: 88 / 255, alpha: 1)
    case 1:
      return UIColor(displayP3Red: 1, green: 0, blue: 79 / 255, alpha: 1)
    case 2:
      return UIColor(displayP3Red: 1, green: 66 / 255, blue: 136 / 255, alpha: 1)
    case 3:
      return UIColor(displayP3Red: 1, green: 114 / 255, blue: 99 / 255, alpha: 1)
    case 4:
      return UIColor(displayP3Red: 1, green: 152 / 255, blue: 81 / 255, alpha: 1)
    case 5:
      return UIColor(displayP3Red: 0, green: 221 / 255, blue: 163 / 255, alpha: 1)
    case 6:
      return UIColor(displayP3Red: 0, green: 188 / 255, blue: 163 / 255, alpha: 1)
    case 7:
      return UIColor(displayP3Red: 0, green: 168 / 255, blue: 223 / 255, alpha: 1)
    case 8:
      return UIColor(displayP3Red: 76 / 255, green: 102 / 255, blue: 189 / 255, alpha: 1)
    case 9:
      return UIColor(displayP3Red: 69 / 255, green: 84 / 255, blue: 133 / 255, alpha: 1)
    case 10:
      return UIColor(displayP3Red: 141 / 255, green: 158 / 255, blue: 1, alpha: 1)
    case 11:
      return UIColor(displayP3Red: 132 / 255, green: 51 / 255, blue: 1, alpha: 1)
    case 12:
      return UIColor(displayP3Red: 189 / 255, green: 32 / 255, blue: 1, alpha: 1)
    default:
      return UIColor(white: 88 / 255, alpha: 1)
    }
  }
}
