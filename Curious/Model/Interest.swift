//
//  Interest.swift
//  Curious
//
//  Created by Spencer Forrest on 24/12/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

struct Interest {
  
  var title: Title
  var comment: String
  
  init(title: Title, comment: String) {
    self.title = title
    self.comment = comment
  }
}
