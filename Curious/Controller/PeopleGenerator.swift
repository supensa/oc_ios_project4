//
//  PeopleGenerator.swift
//  Curious
//
//  Created by Spencer Forrest on 21/02/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

/// All the logic to generate random people
class PeopleGenerator {
  
  private let kNumberMaxPlayers: Int = 12
  
  private let jobs = [
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
  
  private var names = [
    "John",
    "Marcos",
    "Alicia",
    "Diana",
    "Peter",
    "Joseph",
    "Gabriella",
    "Joanna",
    "Joey",
    "Fred",
    "William",
    "Jason"
  ]
  
  private var people = [String:Person]()
  private var peopleNames = [String]()
  
  /// Get all the people generated
  ///
  /// - Returns: Key: name of person, value: person
  func getPeople() -> [String:Person] {
    return people
  }
  
  /// Array of people's names sorted by their creation order
  ///
  /// - Returns: names of the people created
  func getPeopleNames() -> [String] {
    return peopleNames
  }
  
  /// Create Random players with interests
  ///
  /// - Returns: Dictionary of "person"
  func setup() {
    let peopleCount = Int.random(min: 2, max: 12)
    
    for _ in 1...peopleCount {
      guard let person = createRandomPerson()
        else { continue }
      let name = person.name
      people[name] = person
      peopleNames.append(name)
    }
  }
  
  /// Create a person with a random job
  ///
  /// - Returns: New person or nil
  private func createRandomPerson() -> Person? {
    guard let job = jobs.random(), let name: String = names.randomPop()
      else { return nil }
    return Person(name: name, job: job)
  }
}
