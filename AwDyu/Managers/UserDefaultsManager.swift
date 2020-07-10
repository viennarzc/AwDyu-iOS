//
//  UserDefaultsManager.swift
//  AwDyu
//
//  Created by SCI-Viennarz on 7/9/20.
//  Copyright © 2020 VVC. All rights reserved.
//

import Foundation

/// User options manager
final class UserDefaultsManager {
  public static let shared = UserDefaultsManager()

  private static let kLastVisitKey = "LastVisitDate"


  /// Should record the current date to user defaults
  func saveDateAsLastVisit() {
    //save as Date
    UserDefaults.standard.set(Date(), forKey: UserDefaultsManager.kLastVisitKey)
  }

  /// Should get the last visit date from user defaults
  func getDateLastVisit() -> String? {
    //read
    guard let date = UserDefaults.standard.object(forKey: UserDefaultsManager.kLastVisitKey) as? Date else {
      return nil
    }

    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM d, Y ,hh:mm a"

    return formatter.string(from: date)
  }
  
  ///Returns Bool if stored a date
  var hasPreviousDateVisited: Bool {
    guard (UserDefaults.standard.object(forKey: UserDefaultsManager.kLastVisitKey) as? Date) != nil else {
      return false
    }
    
    return true
  }
}
