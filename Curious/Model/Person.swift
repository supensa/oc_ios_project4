//
//  Person.swift
//  Curious
//
//  Created by Spencer Forrest on 24/12/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

class Person {
  var sharedInterests: [Kind : Interest]
  var unsharedInterests: [Kind] = Kind.getAll()
  
  private(set) var name: String
  private(set) var jobTitle: String
  
  init(name n: String, jobTitle j: String) {
    name = n.capitalized
    jobTitle = j
    sharedInterests = [Kind : Interest]()
  }
}
