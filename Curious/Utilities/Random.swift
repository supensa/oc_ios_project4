//
//  Random.swift
//  Curious
//
//  Created by Spencer Forrest on 15/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

protocol Random {}

extension Random {
  /// Generate a random number
  ///
  /// - Parameter count: Number of integers to chose from
  /// - Returns: Random value between 0 and (count - 1)
  func randomInt(count: Int = Int.max) -> Int {
    return Int(arc4random_uniform(UInt32(count)))
  }
}
