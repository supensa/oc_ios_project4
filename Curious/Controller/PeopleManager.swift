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
  private var people = Array<Person>()
  private var peopleReady = [Person]()
  
  
// TODO Generate Random interests here !!!!!!!!
  /// Create Random players (Random count, unique names, job titles and interest counts)
  func createRandom() {
    let peopleCount = self.randomPeopleCount()
    let availableNames = AvailableNames()
    for _ in 1...peopleCount {
      if let name = availableNames.popRandom() {
        let jobTitle = Job().random()
        let person = Person(name: name, jobTitle: jobTitle, maxNumberInterests: kMaxNumberInterests)
        people.append(person)
      }
    }
  }
  
  /// Display basic pieces of information concerning each player (unique name and job title).
  func displayIntroduction() {
    for index in 0..<people.count {
      print("\nInformation of player #\(index+1):")
      print("\(people[index].name) : \(people[index].jobTitle)")
    }
  }
  
  /// Each person (random order) shares a random interest.
  /// Loop until all people shared all their interests.
  func shareRandomInterests() {
    var peopleReady = [Person]()
    
    while people.count > 0 {
      // Chose a random person and give him a random interest
      let person = popRandomPerson()
      if let interest = generateRandomInterest(person: person) {
        person.sharedInterests.append(interest)
      }
      
      // Check whether random person is ready to be paired
      if person.isReadyForPairing() {
        peopleReady.append(person)
      } else {
        people.append(person)
      }
    }
    people = peopleReady
  }
  
  private func popRandomPerson() -> Person {
    let randomIndex = randomInt(count: people.count)
    return people.remove(at: randomIndex)
  }
  
  private func generateRandomInterest(person: Person) -> Interest? {
    if let title = person.popRandomUnsharedIntrestTitles() {
      let comment = Comment().random()
      return Interest(title: title, comment: comment)
    }
    return nil
  }
  
  /// Generate a random count for people
  ///
  /// - Returns: Count of people
  private func randomPeopleCount() -> Int {
    return Int(arc4random_uniform(kNumberMaxPlayers - 1) + 2)
  }
}
