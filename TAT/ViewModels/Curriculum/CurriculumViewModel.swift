//
//  CurriculumViewModel.swift
//  TAT
//
//  Created by Jamfly on 2019/2/4.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation

struct CurriculumViewModel {

  // MARK: - Public Methods

  func login() {
    _ = APIManager.shared.login(with: "", and: "")
  }

}
