//
//  PaginationViewModel.swift
//  TAT
//
//  Created by Jamfly on 2019/1/31.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PaginationViewModel: NSObject, FetchedItemsBaseViewModel {

  // MARK: - RxPagination

  let refreshTrigger = PublishSubject<Void>()
  let loadNextPageTrigger = PublishSubject<Void>()
  let loadError = PublishSubject<Error>()
  let canLoadMore = BehaviorRelay<Bool>(value: true)
  let isLoading = BehaviorRelay<Bool>(value: false)

  // MARK: - Pagination

  let items = BehaviorRelay<[Any]>(value: [])
  var currentPage: Int = 1
  var totalCreativeCount: Int = 0
  var fetchedItemConversionBlock: ((_: Any?) -> Any?)?
  var totalItemsCount: Int?

  // MARK: - Initialization

  override init() {
    super.init()
    setupFetchObservable()
  }

  // MARK: - Private Methods

  internal func refresh() -> Observable<Int> {
    return Observable<Int>.create { [weak self] observer in
      self?.currentPage = 1
      self?.totalCreativeCount = 0
      self?.canLoadMore.accept(true)
      self?.items.accept([])
      observer.onNext((self?.currentPage)!)
      observer.onCompleted()
      return Disposables.create()
    }
  }

  internal func loadNextPage() -> Observable<Int> {
    return Observable<Int>.create { [weak self] observer in
      self?.currentPage += 1
      observer.onNext((self?.currentPage)!)
      observer.onCompleted()
      return Disposables.create()
    }
  }

  func setupFetchObservable() {
    let refreshRequest = isLoading.asObservable().sample(refreshTrigger)
      .flatMap({ (isLoading) -> Observable<Int> in
        if isLoading {
          return Observable.empty()
        } else {
          return self.refresh()
        }
      })

    let nextPageRequest = isLoading.asObservable().sample(loadNextPageTrigger)
      .flatMap({ (isLoading) -> Observable<Int> in
        if isLoading || !self.canLoadMore.value {
          return Observable.empty()
        } else {
          return self.loadNextPage()
        }
      })

    let request = Observable.merge(refreshRequest, nextPageRequest)
      .share(replay: 1)

    let response = request.flatMapLatest { [unowned self] (_) -> Observable<([Any], Int)> in
      return (self.requestNextPage(at: self.currentPage).do(onError: { [weak self] (error) in
        self?.loadError.onNext(error)
      }).catchErrorJustReturn(([], 1)))
      }
      .share(replay: 1)
      .materialize()

    response
      .asObservable()
      .dematerialize()
      .subscribe(onNext: { [weak self] (element) in
        let recieveItem = element.0
        let totalNum = element.1
        self?.totalItemsCount = totalNum
        self?.updateCurrentStatusByFetchItemSuccessed(recieveItem, totalNum)
        self?.items.accept(self?.currentPage == 1 ? recieveItem : recieveItem + (self?.items.value ?? []))
      })
      .disposed(by: rx.disposeBag)

    Observable.merge(request.map { _ in true },
                     response.map { _ in false },
                     loadError.map { _ in false })
      .bind(to: isLoading)
      .disposed(by: rx.disposeBag)
  }

  // MARK: - subClass override

  func requestNextPage(at page: Int) -> Observable<([Any], Int)> {
    return Observable.empty()
  }

}
