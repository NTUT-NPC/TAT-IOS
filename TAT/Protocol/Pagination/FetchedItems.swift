//
//  FetchedItems.swift
//  TAT
//
//  Created by Jamfly on 2019/1/31.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation
import RxCocoa

protocol FetchedItems: AnyObject {

  var items: BehaviorRelay<[Any]> { get }
  var currentPage: Int { get set }
  var fetchedItemConversionBlock: ((_: Any?) -> Any?)? { get set }

  func numberOfItems() -> Int
  func item(at index: Int) -> Any?
}

extension FetchedItems {

  func numberOfItems() -> Int {
    return items.value.count
  }

  func item(at index: Int) -> Any? {
    if index < 0 || items.value.count <= index {
      return nil
    }
    return items.value[index]
  }

}
