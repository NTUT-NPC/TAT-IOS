//
//  AppDelegate.swift
//  TAT
//
//  Created by Jamfly on 2019/1/29.
//  Copyright © 2019 jamfly. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FAPanels

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    guard let window = window else { fatalError("no windows") }

    setUpDrawer(with: window)
    setUpNavigationBar()
    setUpServices()

    return true
  }

  // MARK: - Private Methods

  private func setUpTabBar() -> UITabBarController {
    let tabBar = UITabBarController()
    tabBar.viewControllers = [
      CurriculumViewController(),
      CalenderViewController(),
      ActivityViewController(),
      LoginViewController()
    ]
    tabBar.tabBar.items?[0].title = "Curriculum"
    tabBar.tabBar.items?[1].title = "Calender"
    tabBar.tabBar.items?[2].title = "Activity"
    tabBar.tabBar.items?[3].title = "Login"
    return tabBar
  }

  private func setUpDrawer(with window: UIWindow) {
    let centerVC = UINavigationController(rootViewController: setUpTabBar())
    let rootVC = FAPanelController()
    _ = rootVC.center(centerVC).left(SettingViewController())
    rootVC.configs.leftPanelWidth = window.bounds.width * 0.6
    window.rootViewController = rootVC
  }

  private func setUpServices() {
    IQKeyboardManager.shared.enable = true
  }

  private func setUpNavigationBar() {
    UINavigationBar.appearance().tintColor = UIColor.white
    UINavigationBar.appearance().barTintColor = UIColor.navigationBarPurple
  }

}
