//
//  Person.swift
//  Curious
//
//  Created by Spencer Forrest on 24/12/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

class Person: Random {
  private var sharedInterests = [Interest]()
  private(set) var numberInterests = 0
  
  private(set) var name: PersonName
  private(set) var jobTitle: String
  
  init(name: PersonName, jobTitle: String, maxNumberInterests: Int) {
    self.name = name.capitalized
    self.jobTitle = jobTitle
    self.numberInterests = randomCount(count: maxNumberInterests)
  }
  
  /// Add interest to the 'sharedInterests' array
  ///
  /// - Parameter interest: interest that might be added
  func addInterest(_ interest: Interest) {
    sharedInterests.append(interest)
  }
}
