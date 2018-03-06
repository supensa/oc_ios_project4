//
//  Pair.swift
//  Curious
//
//  Created by Spencer Forrest on 23/02/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

/// Represent a person, his partner and their different interest(s)
class Pair {
  private(set) var person: Person
  private(set) var partner: Person
  private(set) var interests: [Interest]
  
  init(person: Person, partner: Person, interests: [Interest]) {
    self.person = person
    self.partner = partner
    self.interests = interests
  }
    
  func addInterests(interests: [Interest]) {
    self.interests.append(contentsOf: interests)
  }
}
