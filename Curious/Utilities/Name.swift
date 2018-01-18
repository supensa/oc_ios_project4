//
//  AvailableNames.swift
//  Curious
//
//  Created by Spencer Forrest on 04/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

class Name: RandomElement {
  
  private var names = [
    "John",
    "Marcos",
    "Alicia",
    "Diana",
    "Peter",
    "Joseph",
    "Gabriella",
    "Joanna",
    "Joey",
    "Fred",
    "William",
    "Jason"
  ]
  
  init() {
    super.init(array: names)
  }
}
