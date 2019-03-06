//
//  LoginViewModel.swift
//  TAT
//
//  Created by Jamfly on 2019/3/6.
//

import RxSwift
import RxCocoa

struct LoginViewModel {

  // MARK: - Properties

  private let bag = DisposeBag()

  // MARK: - Public Methods

  func login(with account: String,
             password: String,
             stopAnimation: (() -> Void)?) {
    guard let stopAnimation = stopAnimation else { return }
    _ = APIManager.shared.login(with: account, and: password)
    .subscribe(onNext: { (token) in
      guard let token = token as? Token else { return }
      UserDefaults.standard.set(token.tokenString, forKey: "token")
      UserDefaults.standard.set(account, forKey: "account")
      stopAnimation()
    }, onError: { (error) in
      #if DEBUG
      print("failed to login \(error)")
      #endif
      stopAnimation()
    })
    .disposed(by: bag)
  }

  func clear() {
    UserDefaults.standard.removeObject(forKey: "token")
    UserDefaults.standard.removeObject(forKey: "account")
  }

}
