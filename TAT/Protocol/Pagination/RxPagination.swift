//
//  RxPagination.swift
//  TAT
//
//  Created by Jamfly on 2019/1/31.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RxPagination {
  var refreshTrigger: PublishSubject<Void> { get }
  var loadNextPageTrigger: PublishSubject<Void> { get }
  var loadError: PublishSubject<Error> { get }

  var canLoadMore: BehaviorRelay<Bool> { get }
  var isLoading: BehaviorRelay<Bool> { get }
}
