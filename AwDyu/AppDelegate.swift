//
//  AppDelegate.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/7/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
  
    return true
  }
  
  func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
        // Save the current app version to the archive.
    coder.encode(1.0, forKey: "MyAppVersion")

    // Always save state information.
    return true
  }

  func application(_ application: UIApplication,
    shouldRestoreApplicationState coder: NSCoder) -> Bool {
    // Restore the state only if the app version matches.
    let version = coder.decodeFloat(forKey: "MyAppVersion")
    if version == 1.0 {
      return true
    }

    // Do not restore from old data.
    return false
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

