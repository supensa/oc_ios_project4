//
//  Job.swift
//  Curious
//
//  Created by Spencer Forrest on 04/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

class Job: Random {
  
  private var titles = [
    "Fire fighter",
    "Postman",
    "Policeman",
    "Software Engineer",
    "Life guard",
    "Security",
    "English teacher",
    "Data scientist",
    "Database administrator",
    "Janitor",
    "Professional hokey player",
    "Chief Executive Officer"
  ]
  
  init() {
    super.init(array: titles)
  }
}
