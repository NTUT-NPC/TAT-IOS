//
//  BaseViewModel.swift
//  TAT
//
//  Created by Jamfly on 2019/1/31.
//  Copyright © 2019 jamfly. All rights reserved.
//

import Foundation

protocol BaseViewModel: class {
  associatedtype ViewModelType
  var viewModel: ViewModelType? { get set }
}
