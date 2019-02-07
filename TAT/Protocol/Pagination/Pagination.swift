//
//  Pagination.swift
//  TAT
//
//  Created by Jamfly on 2019/1/31.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation

protocol Pagination: BaseViewModel {
  var spinToken: String { get }
  func blockToHandleError() -> (_: Error?) -> Void
  func shouldLoadOneMorePage() -> Bool
}

extension Pagination {

  var spinToken: String {
    return "spinner"
  }

  func shouldLoadOneMorePage() -> Bool {
    guard let viewModel = viewModel as? FetchedItemsBaseViewModel else { return false }
    return viewModel.canLoadMore.value && viewModel.currentPage == 1
  }

}
