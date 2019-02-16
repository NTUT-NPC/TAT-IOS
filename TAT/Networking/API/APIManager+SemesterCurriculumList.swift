//
//  APIManager+SemesterCurriculumList.swift
//  TAT
//
//  Created by 神崎秀吉 on 2019/02/09.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa
import SwiftyJSON

extension APIType {

  struct SemesterCurriculumList: APITargetType {

    // MARK: - Properties

    private var studentID: String?

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

    var headers: [String: String]? {
      guard let token = UserDefaults.standard.string(forKey: "token") else {
        print("QAQ")
        return [:]
      }
      return ["Authorization": "Bearer " + token]
    }

    var task: Task {
      var params: [String: Any] = [:]
      params["targetStudentId"] = studentID

      return .requestParameters(parameters: params,
                                encoding: URLEncoding.queryString)
    }
  }

}

extension APIManager {

  func fetchSemesterCurrirulumList(with studentID: String?) -> Observable<AnyObject> {
    let target = MultiTarget(APIType.SemesterCurriculumList(with: studentID))
    return Observable.create { [weak self] (observer) -> Disposable in
      _ = self?.provider.rx.request(target)
        .asObservable()
        .filterSuccessfulStatusCodes()
        .mapJSON()
        .parseResponseDirectly(asType: [Semester].self)
        .subscribe(onNext: { (semesterList) in
          observer.onNext(semesterList as AnyObject)
          observer.onCompleted()
          #if DEBUG
          print("semester list is \(semesterList)")
          #endif
        }, onError: { (error) in
          #if DEBUG
          print("failed to fetch semester list with: \(error)")
          guard let error = error as? MoyaError else {
            return
          }
          let owo = String(data: (error.response?.data)!, encoding: .utf8)
          print(owo ?? "")
          #endif
        })
      return Disposables.create()
    }
  }

}
