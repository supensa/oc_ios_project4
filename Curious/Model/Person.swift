//
//  Person.swift
//  Curious
//
//  Created by Spencer Forrest on 24/12/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

class Person {
  private var sharedInterests = [Interest]()
  private(set) var job: String
  private(set) var name: String
  
  /// Create a person with a ramdom number of interests
  ///
  /// - Parameters:
  ///   - name: Name of the person
  ///   - jobTitle: Job title of the person
  init(name: String, job: String) {
    self.job = job
    self.name = name
  }
  
  /// Add interest to the 'sharedInterests' array
  ///
  /// - Parameter interest: interest that might be added
  func addInterest(_ interest: Interest) {
    sharedInterests.append(interest)
  }
  
  /// Get the title of the person's interests
  ///
  /// - Returns: Array of titles
  func getInterests() -> [Interest] {
    return sharedInterests
  }
  
  /// Display each interest of the person
  /// -> Title of the interest and a comment
  func displaySharedInterests() {
    let display = sharedInterests.count == 1 ? "Interest" : "Interests"
    print("\t\(display):")
    for interest in sharedInterests {
      print("\t\t--> \(interest.title)")
      print("\t\t\t\(interest.comment)")
    }
  }
}
