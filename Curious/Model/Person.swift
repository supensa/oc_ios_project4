//
//  Person.swift
//  Curious
//
//  Created by Spencer Forrest on 24/12/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

class Person: Random {
  var numberInterests = 0
  var sharedInterests = [Interest]()
  private var unsharedInterestTitles: [Title] = Title.getAll()
  
  private(set) var name: String
  private(set) var jobTitle: String
  
  init(name: String, jobTitle: String, maxNumberInterests: UInt32) {
    self.name = name.capitalized
    self.jobTitle = jobTitle
    self.numberInterests = randomInterestCount(maxNumberInterests)
  }
  
  func popRandomUnsharedIntrestTitles() -> Title? {
    if self.unsharedInterestTitles.isEmpty { return nil }
    
    let interestIndex = randomInt(count: self.unsharedInterestTitles.count)
    return self.unsharedInterestTitles.remove(at: interestIndex)
  }
  
  func isReadyForPairing() -> Bool {
    if name.isEmpty || jobTitle.isEmpty ||
      numberInterests > sharedInterests.count {
      return false
    }
    return true
  }
  
  /// Generate a random number
  ///
  /// - Parameter maxNumberInterests: Maximum possible value of the integer
  /// - Returns: Random value between 1 and max
  private func randomInterestCount(_ maxNumberInterests: UInt32) -> Int {
    return Int(arc4random_uniform(maxNumberInterests) + 1)
  }
}
