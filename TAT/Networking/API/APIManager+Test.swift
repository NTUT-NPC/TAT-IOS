//
//  APIManager+Test.swift
//  TAT
//
//  Created by 神崎秀吉 on 2019/02/21.
//

// TODO: - Delete this file before push anything
import Moya
import RxSwift
import RxCocoa
import SwiftyJSON

// MARK: - APIType
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
        #if DEBUG
        print("failed to get auth token")
        #endif
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
        #if DEBUG
        print("failed to get auth token")
        #endif
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

// MARK: - Parsing methods
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
