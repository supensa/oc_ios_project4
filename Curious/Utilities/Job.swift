//
//  Job.swift
//  Curious
//
//  Created by Spencer Forrest on 04/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

class Job: RandomElement {
  
  private var jobs = [
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
    super.init(array: jobs)
  }
}
