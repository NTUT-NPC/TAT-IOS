//
//  FetchedItemsBaseViewModel.swift
//  TAT
//
//  Created by Jamfly on 2019/1/31.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation
import RxSwift
import NSObject_Rx

protocol FetchedItemsBaseViewModel: FetchedItems, RxPagination {
  func refresh() -> Observable<Int>
  func setupFetchObservable()
}

extension FetchedItemsBaseViewModel {

  func updateCurrentStatusByFetchItemSuccessed(_ items: [Any]?, _ totalItemsCount: Int) {
    guard let items = items else { return }
    canLoadMore.accept(self.items.value.count + items.count <= totalItemsCount)
  }

  func fetchNextPage() -> Observable<[Any]?> {
    return Observable.empty()
  }

}
