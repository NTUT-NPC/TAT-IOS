//
//  LoginViewController.swift
//  TAT
//
//  Created by Jamfly on 2019/3/5.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {

  // MARK: - Properties

  private let viewModel = LoginViewModel()

  private lazy var loginLabel: UILabel = {
    let loginLabel = UILabel(frame: .zero)
    loginLabel.text = "login"
    loginLabel.font = UIFont.boldSystemFont(ofSize: 16)
    return loginLabel
  }()

  // its type will be UIImage in the future
  private lazy var avatar: UIView = {
    let avatar = UIView(frame: .zero)
    avatar.backgroundColor = UIColor.red
    return avatar
  }()

  private lazy var accountTextField: UITextField = {
    let accountTextField = UITextField(frame: .zero)
    accountTextField.placeholder = "Plz enter your student id"
    accountTextField.borderStyle = .roundedRect
    let account = UserDefaults.standard.string(forKey: "account")
    accountTextField.text = account
    return accountTextField
  }()

  private lazy var passwordTextField: UITextField = {
    let passwordTextField = UITextField(frame: .zero)
    passwordTextField.placeholder = "Plz enter your password"
    passwordTextField.borderStyle = .roundedRect
    passwordTextField.isSecureTextEntry = true
    return passwordTextField
  }()

  private lazy var clearButton: UIButton = {
    let clearButton = UIButton(frame: .zero)
    clearButton.setTitle("clear", for: .normal)
    clearButton.backgroundColor = UIColor.red
    clearButton.layer.cornerRadius = 5
    return clearButton
  }()

  private lazy var storeButton: UIButton = {
    let storeButton = UIButton(frame: .zero)
    storeButton.setTitle("store", for: .normal)
    storeButton.backgroundColor = UIColor.blue
    storeButton.layer.cornerRadius = 5
    return storeButton
  }()

  private lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    activityIndicator.color = UIColor.navigationBarPurple
    return activityIndicator
  }()

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Initialization

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nil, bundle: nil)
  }

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    setUpLayouts()
    setUpButtonsTap()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  // MARK: - Private Methods

  private func setUpLayouts() {
    setUpLoginLabel()
    setUpAvatar()
    setUpTextFields()
    setUpButtons()
    setUpActivityIndicator()
  }

  private func setUpLoginLabel() {
    view.addSubview(loginLabel)
    loginLabel.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(100)
    }
  }

  private func setUpAvatar() {
    view.addSubview(avatar)
    avatar.snp.makeConstraints { (make) in
      make.top.equalTo(loginLabel.snp.bottom).offset(12)
      make.centerX.equalToSuperview()
      make.height.equalTo(120)
      make.width.equalTo(120)
    }
    avatar.layer.cornerRadius = 60
  }

  private func setUpTextFields() {
    view.addSubview(accountTextField)
    view.addSubview(passwordTextField)

    accountTextField.snp.makeConstraints { (make) in
      make.centerX.equalToSuperview()
      make.top.equalTo(avatar.snp.bottom).offset(20)
      make.width.equalTo(view.bounds.width * 0.8)
    }

    passwordTextField.snp.makeConstraints { (make) in
      make.left.equalTo(accountTextField)
      make.right.equalTo(accountTextField)
      make.top.equalTo(accountTextField.snp.bottom).offset(30)
    }
  }

  private func setUpButtons() {
    view.addSubview(clearButton)
    view.addSubview(storeButton)

    clearButton.snp.makeConstraints { (make) in
      make.top.equalTo(passwordTextField.snp.bottom).offset(20)
      make.left.equalTo(passwordTextField)
      make.width.equalTo(view.bounds.width * 0.8 * 0.4)
      make.height.equalTo(accountTextField)
    }

    storeButton.snp.makeConstraints { (make) in
      make.top.equalTo(clearButton)
      make.bottom.equalTo(clearButton)
      make.right.equalTo(passwordTextField)
      make.width.equalTo(clearButton)
    }
  }

  private func setUpButtonsTap() {
    clearButton.rx.tap
      .subscribe { [weak self] _ in
        self?.viewModel.clear()
        DispatchQueue.main.async { [weak self] in
          self?.accountTextField.text = nil
          self?.passwordTextField.text = nil
        }
      }
      .disposed(by: rx.disposeBag)

    storeButton.rx.tap
      .subscribe { [weak self] _ in
        guard let account = self?.accountTextField.text, let password = self?.passwordTextField.text else {
          return
        }
        DispatchQueue.main.async {
          self?.activityIndicator.startAnimating()
        }
        self?.viewModel.login(with: account,
                              password: password,
                              stopAnimation: self?.activityIndicator.stopAnimating)
      }
      .disposed(by: rx.disposeBag)
  }

  private func setUpActivityIndicator() {
    view.addSubview(activityIndicator)
    activityIndicator.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
    }
  }

  /*
    wait till we know the use case
    then put it inside `viewDidAppear`
  */
  private func touchIDLogin() {
    activityIndicator.startAnimating()
    viewModel.loginWithAuth(with: activityIndicator.stopAnimating)
    passwordTextField.text = UserDefaults.standard.string(forKey: "password")
  }

}
