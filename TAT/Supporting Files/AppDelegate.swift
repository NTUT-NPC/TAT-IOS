//
//  AppDelegate.swift
//  TAT
//
//  Created by Jamfly on 2019/1/29.
//  Copyright © 2019 jamfly. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    guard let window = window else { fatalError("no windows") }
    //window.rootViewController = CurriculumViewController()
    setUpTabBar(at: window)
    IQKeyboardManager.shared.enable = true
    return true
  }

  // MARK: - Private Methods

  private func setUpTabBar(at window: UIWindow) {
    let tabBar = UITabBarController()
    tabBar.viewControllers = [
      CurriculumViewController(),
      CalenderViewController(),
      ActivityViewController(),
      CreditViewController(),
      SettingViewController()
    ]
    tabBar.tabBar.items?[0].title = "Curriculum"
    tabBar.tabBar.items?[1].title = "Calender"
    tabBar.tabBar.items?[2].title = "Activity"
    tabBar.tabBar.items?[3].title = "Credit"
    tabBar.tabBar.items?[4].title = "Setting"
    window.rootViewController = tabBar
  }

}
