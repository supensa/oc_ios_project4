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
  
  /// Create a person
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
  /// - Parameter interest: interest to add
  func addInterest(_ interest: Interest) {
    sharedInterests.append(interest)
  }
  
  /// Get the person's interests
  ///
  /// - Returns: list of interests
  func getInterests() -> [Interest] {
    return sharedInterests
  }
  
  /// Display each interest of the person:
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

extension Person: Hashable {
  var hashValue: Int {
    return self.name.hashValue &* 16777619
  }
  
  static func == (lhs: Person, rhs: Person) -> Bool {
    return lhs.name == rhs.name
  }
}
