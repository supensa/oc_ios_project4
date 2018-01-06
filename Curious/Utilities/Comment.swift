//
//  Comment.swift
//  Curious
//
//  Created by Spencer Forrest on 04/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

class Comment {
  
  static private var comments = getComments()
  
  static private var getComments = {
    return [
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
  }
  
  static func reload() {
    comments = getComments()
  }
  
  static func getRandom() -> String? {
    if comments.isEmpty { return nil}
    let index = Int(arc4random_uniform(UInt32(comments.count)))
    return comments.remove(at: index)
  }
}
