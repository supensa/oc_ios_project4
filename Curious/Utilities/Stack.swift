//
//  Stack.swift
//  Curious
//
//  Created by Spencer Forrest on 27/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

/// Stack of items that can be poped out or pushed in
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
/// A type-erased wrapper over any stack
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
