//
//  LoginViewModel.swift
//  TAT
//
//  Created by Jamfly on 2019/3/6.
//

import RxSwift
import RxCocoa
import LocalAuthentication

class LoginViewModel {

  // MARK: - Properties

  private let bag = DisposeBag()

  private lazy var context: LAContext = {
    let context = LAContext()
    context.localizedCancelTitle = "Enter Username/Password"
    return context
  }()

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
        UserDefaults.standard.set(password, forKey: "password")
        DispatchQueue.main.async {
          stopAnimation()
        }
    }, onError: { (error) in
      #if DEBUG
      print("failed to login \(error)")
      #endif
      DispatchQueue.main.async {
        stopAnimation()
      }
    })
    .disposed(by: bag)
  }

  func loginWithAuth(with stopAnimation: (() -> Void)?) {
    var error: NSError?
    if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
      let reason = "Log in to your account"
      context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { [weak self] success, error in
        if success {
          guard let account = UserDefaults.standard.string(forKey: "account"), let password = UserDefaults.standard.string(forKey: "password") else { return }
          self?.login(with: account,
                      password: password,
                      stopAnimation: stopAnimation)
        } else {
          #if DEBUG
          print("failed login via touchID/faceID \(String(describing: error))")
          #endif
          guard let stopAnimation = stopAnimation else { return }
          DispatchQueue.main.async {
            stopAnimation()
          }
        }
      }
    }
  }

  func clear() {
    UserDefaults.standard.removeObject(forKey: "token")
    UserDefaults.standard.removeObject(forKey: "account")
    UserDefaults.standard.removeObject(forKey: "password")
  }

}
