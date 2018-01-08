//
//  Person.swift
//  Curious
//
//  Created by Spencer Forrest on 24/12/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

class Person {
  var numberInterests = 0
  var sharedInterests = [Title : Interest]()
  var unsharedInterestTitles: [Title] = Title.getAll()
  
  private(set) var name: String
  private(set) var jobTitle: String
  
  init(name n: String, jobTitle j: String) {
    name = n.capitalized
    jobTitle = j
  }
}
