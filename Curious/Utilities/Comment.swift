//
//  Comment.swift
//  Curious
//
//  Created by Spencer Forrest on 04/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

class Comment: Random {
  
  private var comments  = [
    "It helps me relax",
    "I become more inspired",
    "It helps me to clear my mind",
    "It reminds me of the good old time",
    "It is a fun activity",
    "It is an activity I like to do with friends",
    "It keeps me open-minded",
    "I like to broaden my knowledge",
    "I like it since my childhood",
    "It always motivates me in life",
    "It helps me to take a break",
    "I can relieve my stress with this activity"
  ]
  
  init() {
    super.init(array: comments)
  }
}
