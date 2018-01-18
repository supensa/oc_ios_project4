//
//  PeopleManager.swift
//  Curious
//
//  Created by Spencer Forrest on 14/01/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

/// Object managing people and their interests
class PeopleManager: Random {
  
  private var people = [Person]()
  private var personUnsharedTitles = [PersonName:Title]()
  
  /// Display basic pieces of information concerning each person (unique name, job title and interests).
  func displayIntroduction() {
    for index in 0..<people.count {
      let person = people[index]
      print("\nInformation of player #\(index + 1):")
      print("\(person.name) : \(person.job)")
      person.displaySharedInterests()
    }
  }
  
  /// Create Random players (Random count, job titles, interests and unique names)
  func generateRandom() {
    let peopleCount = randomPeopleCount()
    let name = Name()
    for _ in 1...peopleCount {
      guard let person = createRandomPerson(with: name)
        else { continue }
      setupRandomInterets(of: person)
      people.append(person)
    }
  }
  
  /// Create a person with a random job
  ///
  /// - Returns: Person
  private func createRandomPerson(with name: Name) -> Person? {
    guard let name = name.popRandom()
      else { return nil }
    let job = Job().random()
    return Person(name: name, job: job)
  }
  
  /// Setup random interests of a person
  ///
  /// - Parameter person: Selected person
  private func setupRandomInterets(of person: Person) {
    let name = person.name
    personUnsharedTitles[name] = Title()
    let interestCount = randomCount(count: kMaxNumberInterests)
    for _ in 1...interestCount {
      guard let interest = createRandomInterest(of: name)
        else { continue }
      person.addInterest(interest)
    }
  }
  
  /// Create an interest with random title and random comment
  ///
  /// - Parameter name: Name of person who will have the interest
  /// - Returns: Interest
  private func createRandomInterest(of name: PersonName) -> Interest? {
    guard let title = personUnsharedTitles[name]?.popRandom()
      else { return nil }
    let comment = Comment().random()
    return Interest(title: title, comment: comment)
  }
  
  /// Generate random number of people between 2 and 12
  ///
  /// - Returns: Count of people
  private func randomPeopleCount() -> Int {
    return randomIndex(count: (kNumberMaxPlayers - 1)) + 2
  }
}
