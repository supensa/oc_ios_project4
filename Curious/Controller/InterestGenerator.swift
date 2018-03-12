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
  
  private var peoplePerUnsharedInterest = [Interest:Dictionary<String,Person>]()
  
  /// A dictionary which maps unshared interest with people
  ///
  /// - Returns: Dictionary with Key: interest and Value: people who don't share the interest
  func getPeoplePerUnsharedInterest() -> [Interest:Array<Person>] {
    var dictionary = [Interest:Array<Person>]()
    for (interest, people) in peoplePerUnsharedInterest {
      dictionary[interest] = people.map { $0.value }
    }
    return dictionary
  }
  
  /// Setup random interest(s) of a person
  /// Keeping track of the interests that are not shared by some people
  ///
  /// - Parameter people: Dictionary of people
  func setup(people: [String:Person]) {
    for (name, person) in people {
      let interestCount = Int.random(min: kMinNumberInterests, max: kMaxNumberInterests)
      var unsharedInterest = titles
      for _ in 1...interestCount {
        guard let interest = createRandomInterest(title: unsharedInterest.randomPop())
          else { continue }
        person.addInterest(interest)
        updatePeoplePerUnsharedInterest(people: people, interest: interest, name: name)
      }
    }
  }
  
  /// Update the list of people that do not share a specific interest.
  /// This is done by removing the person known to share this interest
  /// from a list containing all the people.
  ///
  /// - Parameters:
  ///   - people: List of all people
  ///   - interest: Specific unshared interest
  ///   - name: Name of a person sharing that interest
  private func updatePeoplePerUnsharedInterest(people: [String:Person], interest: Interest, name: String) {
    if (peoplePerUnsharedInterest[interest] == nil) { peoplePerUnsharedInterest[interest] = people }
    peoplePerUnsharedInterest[interest]?.removeValue(forKey: name)
  }
  
  /// Create an interest with a random title and a random comment
  ///
  /// - Parameter title: title of the new interest
  /// - Returns: New interest or nil
  private func createRandomInterest(title: String?) -> Interest? {
    guard let title = title, let comment: String = comments.random()
      else { return nil }
    return Interest(title: title, comment: comment)
  }
}
