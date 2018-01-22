//
//  Game.swift
//  Curious
//
//  Created by Spencer Forrest on 24/12/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

class Game {
  
  private let kMaxNumberInterests: Int = 5
  private let kNumberMaxPlayers: Int = 12
  
  private var people = [Person]()
  private var personUnsharedTitles = [String:Array<String>]()
  
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
    "Fred",
    "Writing"
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
  
  func start() {
    
    print("Aloha !\nThis the 'Curious Katie' app.\n")
    
    generateRandom()
    displayIntroduction()
//    pairingPeople()
    
    print("\n- THE END -")
  }
  
  func pairingPeople() {
    for person in people {
      // TO DO check differences for each person
      print(person.name)
    }
  }
  
  /// Create Random players (Random count, job titles, interests and unique names)
  func generateRandom() {
    let peopleCount = Int.random(min: 2, max: 12)
    let stackNames: Stack = RandomStack<String>(array: self.names)
    for _ in 1...peopleCount {
      guard let person = createRandomPerson(with: stackNames)
        else { continue }
      setupRandomInterets(of: person)
      people.append(person)
    }
  }
  
  /// Display basic pieces of information concerning each person (unique name, job title and interests).
  func displayIntroduction() {
    for index in 0..<people.count {
      let person = people[index]
      print("\nInformation of player #\(index + 1):")
      print("\(person.name) : \(person.job)")
      person.displaySharedInterests()
    }
  }
  
  /// Create a person with a random job
  ///
  /// - Returns: Person
  private func createRandomPerson(with names: Stack) -> Person? {
    guard let name: String = names.pop(), let job = jobs.random()
      else { return nil }
    return Person(name: name, job: job)
  }
  
  /// Setup random interests of a person
  ///
  /// - Parameter person: Selected person
  private func setupRandomInterets(of person: Person) {
    let name = person.name
    personUnsharedTitles[name] = titles
    let interestCount = Int.random(min: 1, max: kMaxNumberInterests)
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
  private func createRandomInterest(of name: String) -> Interest? {
    guard let title = personUnsharedTitles[name]?.random(), let comment: String = comments.random()
      else { return nil }
    return Interest(title: title, comment: comment)
  }
}
