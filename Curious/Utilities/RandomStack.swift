//
//  RandomStack.swift
//  Curious
//
//  Created by Spencer Forrest on 13/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

protocol Stack {
  associatedtype Element
  
  /// Push one element in
  ///
  /// - Parameter element: Element to be pushed in
  func push(_ element: Element) -> ()
  
  /// Pop one element out.
  /// Return nil if the stack is empty
  ///
  /// - Returns: Element from stack
  func pop() -> Element?
}

// "Type Erasure" pattern
class AnyStack<T>: Stack {
  private let _push: (T) -> ()
  private let _pop: () -> T?
  
  required init<S: Stack>(_ seq: S) where S.Element == T {
    _push = seq.push
    _pop = seq.pop
  }
  
  func push(_ element: T) {
    _push(element)
  }
  
  func pop() -> T? {
    return _pop()
  }
}

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
