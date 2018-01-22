//
//  RandomStack.swift
//  Curious
//
//  Created by Spencer Forrest on 13/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

protocol Stack {
//  associatedtype Element
  
  /// Push one element in
  ///
  /// - Parameter element: Element to be pushed in
  func push<Element>(_ element: Element) -> ()
  
  /// Pop one element out.
  /// Return nil if the stack is empty
  ///
  /// - Returns: Element from stack
  func pop<Element>() -> Element?
}

class RandomStack<Type>: Stack {
  
  private var data: Array<Type>
  
  init(array: [Type]) {
    data = array
  }
  
  func push<Element>(_ element: Element) {
    if let element = element as? Type {
      data.append(element)
    } else {
      print("ERROR: '\(element)' cannot be added to the stack")
      print("CAUSE: A '\(type(of: Element.self))' element cannot be appended to a '\(type(of: Type.self))' stack.")
    }
  }
  
  func pop<Element>() -> Element? {
    if data.isEmpty { return nil }
    let index = Int.random(min: 0, max: data.count-1)
    return data.remove(at: index) as? Element
  }
}
