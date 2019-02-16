//
//  APIManager+SemesterCurriculum.swift
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

  struct SemesterCurriculum: APITargetType {

    // MARK: - Properties

    private var studentID: String?
    private var year: String = ""
    private var semester: String = ""

    // MARK: - Initialization

    init(year: String, semester: String, studentID: String?) {
      self.year = year
      self.semester = semester
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
      var params: [String: Any] = [
        "year": year,
        "sem": semester
      ]

      params["targetStudentId"] = studentID

      return .requestParameters(parameters: params,
                                encoding: URLEncoding.queryString)
    }
  }

}

extension APIManager {

  // MARK: - Unwritten yet

  func fetchSemesterCurriculum(year: String, semester: String, studentID: String?) -> Observable<AnyObject> {
    let target = MultiTarget(APIType.SemesterCurriculum(year: year, semester: semester, studentID: studentID))
    return Observable.create { [weak self] (observer) -> Disposable in
      _ = self?.provider.rx.request(target)
      .asObservable()
      .filterSuccessfulStatusCodes()
      .mapJSON()
      .parseResponseDirectly(asType: [Course].self)
        .subscribe(onNext: { (courses) in
          observer.onNext(courses as AnyObject)
          observer.onCompleted()
          #if DEBUG
          print("curriculum is \(courses)")
          #endif
        }, onError: { (error) in
          #if DEBUG
          print("failed to fetch curriculum with: \(error)")
          #endif
        })
      return Disposables.create()
    }
  }
}
