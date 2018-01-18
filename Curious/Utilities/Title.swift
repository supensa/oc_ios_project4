//
//  Title.swift
//  Curious
//
//  Created by Spencer Forrest on 03/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

class Title: RandomElement {
  
  private var titles = [
    "iOS developement",
    "Android development",
    "Learning Mandarin",
    "Playing board games",
    "Watching movies",
    "Hiking",
    "Swimming",
    "Travelling",
    "Dancing",
    "Fred",
    "Writing"
  ]
  
  init() {
    super.init(array: titles)
  }
  
  func getAll() -> [String] {
    return self.titles
  }
}
