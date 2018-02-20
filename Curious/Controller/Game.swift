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
  
  typealias Name = String
  typealias Title = String
  
  private var playerNames = [Name]()
  private var people = [Name:Person]()
  private var pairing = [Name:[Name]]()
  
  // TODO Second dictionaey how to fill in default values for beginning
  private var namesForEachInterestTitleUnshared = [Title:Dictionary<Name,Person>]()
  
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
    "Reading",
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
    pairingPeople()
    displayPairs()
    
    print("\n- THE END -")
  }
  
  private func displayPairs() {
    // START DEBUG
//    for (name, person) in people {
//      print("\n\(name)")
//      print("\(person.getTitleInterests())")
//    }
    // END DEBUG
    
    let sentence = pairing.isEmpty ? "\nThere is no pair." : "\nThe pairs are:"
    
    print(sentence)
    
    for (name, array) in pairing {
      print("\(name) with:")
      for pair in array {
        print("\t-> \(pair)")
      }
    }
  }
  
  private func pairingPeople() {
    guard people.count > 0 else { return }
    
    for name in playerNames {
      
      var namePotentialPairs = [String:Int]()
      
      if let titles = people[name]?.getTitleInterests() {
        for i in 0..<titles.count {
          
          let title = titles[i]
          
          guard let titleDictionary = namesForEachInterestTitleUnshared[title] else { continue }
          if titleDictionary.isEmpty { continue }
          
          for (nameWithoutTitle,_) in titleDictionary {
            if namePotentialPairs[nameWithoutTitle] == nil {
              namePotentialPairs[nameWithoutTitle] = 1
            } else {
              namePotentialPairs[nameWithoutTitle]! += 1
            }
          }
        }
        
        if namePotentialPairs.isEmpty { continue }
        
        for (namePotentialPair, totalDifference) in namePotentialPairs {
          if titles.count == totalDifference {
            if pairing[name] == nil { pairing[name] = [String]() }
            pairing[name]?.append(namePotentialPair)
          }
        }
      }
    }
  }
  
  /// Create Random players (Random count, job titles, interests and unique names)
  private func generateRandom() {
    let peopleCount = Int.random(min: 2, max: 12)
    let stackNames = AnyStack(RandomStack<String>(self.names))
        
    for _ in 1...peopleCount {
      guard let person = createRandomPerson(with: stackNames)
        else { continue }
      let name = person.name
      playerNames.append(name)
      people[name] = person
    }
    
    setupRandomInterets(from: people)
  }
  
  /// Display basic pieces of information concerning each person (unique name, job title and interests).
  private func displayIntroduction() {
    for index in 0..<people.count {
      let name = playerNames[index]
      let person = people[name]!
      print("\nInformation of player #\(index + 1):")
      print("\(person.name) : \(person.job)")
      person.displaySharedInterests()
    }
  }
  
  /// Create a person with a random job
  ///
  /// - Returns: Person
  // name:Setup Game ?
  private func createRandomPerson(with names: AnyStack<String>) -> Person? {
    guard let name: String = names.pop(), let job = jobs.random()
      else { return nil }
    return Person(name: name, job: job)
  }
  
  /// Setup random interests of a person
  ///
  /// - Parameter person: Selected person
  private func setupRandomInterets(from dictionary: [String:Person]) {
    for (name, person) in dictionary {
      let interestCount = Int.random(min: 1, max: kMaxNumberInterests)
      var unsharedInterest = titles
      for _ in 1...interestCount {
        guard let interest = createRandomInterest(title: unsharedInterest.randomPop())
          else { continue }
        let title = interest.title
        if (namesForEachInterestTitleUnshared[title] == nil) { namesForEachInterestTitleUnshared[title] = dictionary }
        namesForEachInterestTitleUnshared[title]?.removeValue(forKey: name)
        person.addInterest(interest)
      }
    }
  }
  
  /// Create an interest with random title and random comment
  ///
  /// - Parameter name: Name of person who will have the interest
  /// - Returns: Interest
  private func createRandomInterest(title: String?) -> Interest? {
    guard let title = title, let comment: String = comments.random()
      else { return nil }
    return Interest(title: title, comment: comment)
  }
}
