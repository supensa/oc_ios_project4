//
//  RandomStack.swift
//  Curious
//
//  Created by Spencer Forrest on 13/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

class RandomStack<T>: Stack {
  private var data: [T]
  
  required init(_ data: [T]) {
    self.data = data
  }
  
  func push(_ element: T) {
    data.append(element)
  }
  
  func pop() -> T? {
    if data.isEmpty { return nil }
    let index = Int.random(min: 0, max: data.count-1)
    return data.remove(at: index)
  }
}
