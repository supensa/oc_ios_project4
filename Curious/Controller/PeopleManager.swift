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
  private var unsharedInterestTitles = [PersonName:Array<Title>]()
  
  /// Display basic pieces of information concerning each player (unique name and job title).
  func displayIntroduction() {
    for index in 0..<people.count {
      print("\nInformation of player #\(index + 1):")
      print("\(people[index].name) : \(people[index].jobTitle)")
    }
  }
  
  /// Create Random players (Random count, unique names, job titles and interest counts)
  func generateRandom() {
    let peopleCount = randomPeopleCount()
    let availableNames = AvailableNames()
    for _ in 1...peopleCount {
      guard let name = availableNames.popRandom()
        else { continue }
      unsharedInterestTitles[name] = Title.getAll()
      let person = createPerson(name: name)
      setupRandomInterets(of: person)
      people.append(person)
    }
  }
  
  /// Setup random interests of a person
  ///
  /// - Parameter person: Selected person
  private func setupRandomInterets(of person: Person) {
    let personName = person.name
    for _ in 1...person.numberInterests {
      guard let title = popUnsharedInterestTitle(forName: personName) else { continue }
      let interest = createInterest(title: title)
      person.addInterest(interest)
    }
  }
  
  /// Pop random unshared interest title for a specific person
  ///
  /// - Parameter name: Name of the person who wants the random title
  /// - Returns: title
  private func popUnsharedInterestTitle(forName name: PersonName) -> Title? {
    guard var titles = unsharedInterestTitles[name]
      else { return nil }
    if titles.isEmpty { return nil }
    let count = titles.count
    let index = randomIndex(count: count)
    return titles.remove(at: index)
  }
  
  private func createPerson(name: String) -> Person {
    let name = name
    let jobTitle = Job().random()
    return Person(name: name, jobTitle: jobTitle, maxNumberInterests: kMaxNumberInterests)
  }
  
  private func createInterest(title: Title) -> Interest {
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
