//
//  DebugPrint.swift
//  TAT
//
//  Created by Jamfly on 2019/2/4.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation

protocol DebugPrint {
  func debugPrint(_ text: Any)
}

extension DebugPrint {

  func debugPrint(_ text: Any) {
    #if DEBUG
    print(text)
    #endif
  }

}
