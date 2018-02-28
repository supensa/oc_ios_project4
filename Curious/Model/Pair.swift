//
//  Pair.swift
//  Curious
//
//  Created by Spencer Forrest on 23/02/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

/// Name of a person and names of his partner
class Pair {
  private(set) var personName: String
  private(set) var pairNames: [String]
  
  init(personName: String, pairNames: [String]) {
    self.personName = personName
    self.pairNames = pairNames
  }
}
