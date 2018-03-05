//
//  InterestGenerator.swift
//  Curious
//
//  Created by Spencer Forrest on 21/02/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

/// All the logic to generate random interests
class InterestGenerator {
  
  private let kMaxNumberInterests: Int = 5
  private let kMinNumberInterests: Int = 1
  
  private let comments  = [
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
  
  private let titles = [
    "iOS developement",
    "Android development",
    "Learning Mandarin",
    "Playing board games",
    "Watching movies",
    "Hiking",
    "Swimming",
    "Travelling",
    "Dancing",
    "Reading",
    "Writing"
  ]
  
  private var peopleForEachUnsharedInterestTitle = [Interest:Dictionary<String,Person>]()
  
  /// A dictionary that maps unshared interest titles with people
  ///
  /// - Returns: Dictionary with "interest title" as Key and a Array of people's name as value
  func getnamesPerUnsharedInterestTitle() -> [Interest:Array<Person>] {
    var dictionary = [Interest:Array<Person>]()
    for (interest, people) in peopleForEachUnsharedInterestTitle {
      dictionary[interest] = people.map { $0.value }
    }
    return dictionary
  }
  
  /// Setup random interests of a person
  ///
  /// - Parameter dictionary: Selected people
  func setup(for dictionary: [String:Person]) {
    for (name, person) in dictionary {
      let interestCount = Int.random(min: kMinNumberInterests, max: kMaxNumberInterests)
      var unsharedInterest = titles
      for _ in 1...interestCount {
        guard let interest = createRandomInterest(title: unsharedInterest.randomPop())
          else { continue }
        if (peopleForEachUnsharedInterestTitle[interest] == nil) { peopleForEachUnsharedInterestTitle[interest] = dictionary }
        peopleForEachUnsharedInterestTitle[interest]?.removeValue(forKey: name)
        person.addInterest(interest)
      }
    }
  }
  
  /// Create an interest with random title and random comment
  ///
  /// - Parameter title: title of the new interest
  /// - Returns: New interest or nil
  private func createRandomInterest(title: String?) -> Interest? {
    guard let title = title, let comment: String = comments.random()
      else { return nil }
    return Interest(title: title, comment: comment)
  }
}
