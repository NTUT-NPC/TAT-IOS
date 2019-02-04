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
import SwiftyJSON

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
      return "/api/login"
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
    let target = MultiTarget(APIType.Login(with: studentID, and: password))
    return Observable.create { [weak self] (observer) -> Disposable in
      _ = self?.provider.rx.request(target)
        .asObservable()
        .filterSuccessfulStatusCodes()
        .mapJSON()
        .parseResponseDirectly(asType: Token.self)
        .subscribe(onNext: { (token) in
          observer.onNext(token as AnyObject)
          observer.onCompleted()
          self?.debugPrint("token is \(token)")
          UserDefaults.standard.set(token, forKey: "token")
        }, onError: { [weak self] (error) in
          observer.onError(error)
          self?.debugPrint("failed to login with: \(error)")
        })
      return Disposables.create()
    }
  }

}
