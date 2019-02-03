//
//  NSObject+TATLog.swift
//  TAT
//
//  Created by Jamfly on 2019/1/30.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation

extension NSObject {

  func TATLog(_ text: Any) {
    #if DEBUG
    print(text)
    #endif
  }

}
