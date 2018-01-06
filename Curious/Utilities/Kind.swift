//
//  Kind.swift
//  Curious
//
//  Created by Spencer Forrest on 03/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

enum Kind: String {
  case ios = "iOS developement"
  case android = "Android development"
  case mandarin = "Learning Mandarin"
  case baordgame = "Playing board games"
  case movie = "Watching movies"
  case hiking = "Hiking"
  case swimming = "Swimming"
  case travelling = "Travelling"
  case dancing = "Dancing"
  case writting = "Writing"
  
  static func getAll() -> [Kind] {
    return [
      .ios,
      .android,
      .mandarin,
      .baordgame,
      .movie,
      .hiking,
      .swimming,
      .travelling,
      .dancing,
      .writting
    ]
  }
}
