//
//  Name.swift
//  Curious
//
//  Created by Spencer Forrest on 04/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

class Name {
  
  static private var names = [
    "John",
    "Marcos",
    "Alicia",
    "Diana",
    "Peter",
    "Joseph",
    "Gabriella",
    "Joanna",
    "Joey",
    "念恩",
    "William",
    "Jason"
  ]
  
  static func getRandom() -> String? {
    if names.isEmpty { return nil }
    let index = Int(arc4random_uniform(UInt32(names.count)))
    return names.remove(at: index)
  }
}
