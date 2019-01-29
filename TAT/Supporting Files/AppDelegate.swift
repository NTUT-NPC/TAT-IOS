//
//  AppDelegate.swift
//  TAT
//
//  Created by Jamfly on 2019/1/29.
//  Copyright © 2019 jamfly. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    guard let window = window else { fatalError("no windows") }
    window.rootViewController = CurriculumViewController()
    return true
  }

}
