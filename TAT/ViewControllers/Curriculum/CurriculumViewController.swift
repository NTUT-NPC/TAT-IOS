//
//  CurriculumViewController.swift
//  TAT
//
//  Created by Jamfly on 2019/1/29.
//  Copyright © 2019 jamfly. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CurriculumViewController: BaseViewController {

  // MARK: - Properties

  private let viewModel = CurriculumViewModel()

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.login()
  }

}
