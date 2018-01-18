//
//  Interest.swift
//  Curious
//
//  Created by Spencer Forrest on 24/12/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

struct Interest {
  
  var title: String
  var comment: String
  
  /// Create a Interest
  ///
  /// - Parameters:
  ///   - title: Title of the interest
  ///   - comment: Comment about the interest.
  init(title: String, comment: String) {
    self.title = title
    self.comment = comment
  }
}
