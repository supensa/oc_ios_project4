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
    let noPairs = pairingPeople()
    displayPairs(noPairs)
    
    print("\n- THE END -")
  }
  
  private func displayPairs(_ noPairs: [Name:Person]?) {
    let sentence = pairing.isEmpty ? "\nThere is no pair." : "\nThe pairs are:\n"
    print(sentence)
    
    for (name, array) in pairing {
      print("\t\(name) with:")
      for pair in array {
        print("\t\t-> \(pair)")
      }
    }
    
    if let noPairs = noPairs, !noPairs.isEmpty, !pairing.isEmpty {
      print("\nNo pair found for:")
      for (name,_) in noPairs {
        print("\t-> \(name)")
      }
    }
  }
  
  /// Pair people that do not share any common interest
  private func pairingPeople() -> [String:Person]? {
    guard people.count > 0 else { return nil }
    var noPairs = people
    
    for name in playerNames {
      
      guard let titles = people[name]?.getTitleInterests() else { continue }
      var namePotentialPairs = [Name:Int]()
      
      for title in titles{
        
        guard let titleDictionary = namesForEachInterestTitleUnshared[title] else { continue }
        
        for (nameWithoutTitle,_) in titleDictionary {
          if namePotentialPairs[nameWithoutTitle] == nil {
            namePotentialPairs[nameWithoutTitle] = 1
          } else {
            namePotentialPairs[nameWithoutTitle]! += 1
          }
        }
      }
      
      for (namePotentialPair, totalDifference) in namePotentialPairs {
        if titles.count == totalDifference {
          if pairing[name] == nil { pairing[name] = [Name]() }
          pairing[name]?.append(namePotentialPair)
          noPairs.removeValue(forKey: name)
        }
      }
    }
    return noPairs
  }
  
  /// Create Random players with interests
  private func generateRandom() {
    let peopleCount = Int.random(min: 2, max: 12)
    
    for _ in 1...peopleCount {
      guard let person = createRandomPerson()
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
  /// - Returns: New person or nil
  private func createRandomPerson() -> Person? {
    guard let name: String = names.randomPop(), let job = jobs.random()
      else { return nil }
    return Person(name: name, job: job)
  }
  
  /// Setup random interests of a person
  ///
  /// - Parameter dictionary: Selected people
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
  /// - Parameter title: title of the new interest
  /// - Returns: New interest or nil
  private func createRandomInterest(title: String?) -> Interest? {
    guard let title = title, let comment: String = comments.random()
      else { return nil }
    return Interest(title: title, comment: comment)
  }
}

