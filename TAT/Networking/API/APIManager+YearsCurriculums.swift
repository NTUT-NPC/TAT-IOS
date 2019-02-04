//
//  APIManager+YearsCurriculums.swift
//  TAT
//
//  Created by Jamfly on 2019/2/4.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa
import SwiftyJSON

extension APIType {

  struct YearsCurriculums: APITargetType {

    // MARK: - Properties

    private let studentID: String?
    
    // MARK: - Initialization

    init(with studentID: String?) {
      self.studentID = studentID
    }

    // MARK: - APITargetType

    var path: String {
      return "/api/curriculums"
    }

    var method: Moya.Method {
      return .get
    }

    var task: Task {
      guard let studentID = studentID else {
        return .requestPlain
      }
      return .requestParameters(parameters: ["targetStudentId": studentID],
                                encoding: JSONEncoding.default)
    }
  }

}

extension APIManager {

  func fetchYearsCurriculums(with studentID: String?) -> Observable<Any> {
    let target = MultiTarget(APIType.YearsCurriculums(with: studentID))
    return Observable.create({ [weak self] (observer) -> Disposable in
      _ = self?.provider.rx.request(target)
        .asObservable()
        .filterSuccessfulStatusCodes()
        .subscribe(onNext: { (response) in
          observer.onNext(response)
          observer.onCompleted()
          self?.debugPrint(response)
        }, onError: { (error) in
          observer.onError(error)
          self?.debugPrint("failed to fetch YearsCurriculums with : \(error)")
        })
      return Disposables.create()
    })
  }


}
