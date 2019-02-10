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

    var task: Task {
      var params: [String: Any] = [:]
      params["targetStudentId"] = studentID

      return .requestParameters(parameters: params,
                                encoding: URLEncoding.queryString)
    }
  }

}

extension APIManager {

  // MARK: - Unwritten yet

}
