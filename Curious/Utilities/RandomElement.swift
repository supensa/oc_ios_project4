//
//  Random.swift
//  Curious
//
//  Created by Spencer Forrest on 13/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

class RandomElement: Random {
  
  private var data: [String]
  
  init(array: [String]) {
    data = array
  }
  
  /// Pop one string out
  /// Return nil if array is empty
  ///
  /// - Returns: Random string from array
  func popRandom() -> String? {
    if data.isEmpty { return nil }
    let index = randomIndex(count: data.count)
    return data.remove(at: index)
  }
  
  /// Return a random string from the array
  ///
  /// - Returns: Random string
  func random() -> String {
    let index = randomIndex(count: data.count)
    return data[index]
  }
}
