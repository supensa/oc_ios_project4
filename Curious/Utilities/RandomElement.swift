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
  
  func popRandom() -> String? {
    if data.isEmpty { return nil }
    let index = randomInt(count: data.count)
    return data.remove(at: index)
  }
  
  func random() -> String {
    let index = randomInt(count: data.count)
    return data[index]
  }
}
