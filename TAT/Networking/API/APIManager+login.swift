//
//  APIManager+login.swift
//  TAT
//
//  Created by Jamfly on 2019/2/3.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa

extension APIType {

  struct Login: APITargetType {

    // MARK: - Properties

    private var studentID: String = ""
    private var password: String = ""

    // MARK: - Initialization

    init(with studentID: String, and password: String) {
      self.studentID = studentID
      self.password = password
    }

    // MARK: - APITargetType

    var path: String {
      return "api/login.json"
    }

    var method: Moya.Method {
      return .post
    }

    var task: Task {
      let params = [
        "studentId": studentID,
        "password": password
      ]
      return .requestParameters(parameters: params,
                                encoding: JSONEncoding.default)
    }
  }

}

extension APIManager {

  func login(with studentID: String, and password: String) -> Observable<AnyObject> {
    TATLog("login....")
    let target = MultiTarget(APIType.Login(with: studentID, and: password))
    return Observable.create { [weak self] (observer) -> Disposable in
      _ = self?.provider.rx.request(target)
        .asObservable()
        .subscribe(onNext: { response in
          observer.onNext(response)
          observer.onCompleted()
          self?.TATLog(response)
        }, onError: { (error) in
          observer.onError(error)
        })
      return Disposables.create()
    }
  }

}
