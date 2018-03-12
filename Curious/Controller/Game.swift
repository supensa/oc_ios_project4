//
//  Game.swift
//  Curious
//
//  Created by Spencer Forrest on 24/12/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

class Game {
  
  private let peopleGenerator = PeopleGenerator()
  private let interestGenerator = InterestGenerator()
  private let pairManager = PairManager()
  
  private var people = [String:Person]()
  private var peopleNames = [String]()
  private var pairs = [Pair]()
  
  func generatePeople() {
    peopleGenerator.setup()
    people = peopleGenerator.getPeople()
    peopleNames = peopleGenerator.getPeopleNames()
  }
  
  func generatePeopleInterests() {
    if people.isEmpty {
      print("Error: We need to generate random people first. Then we can generate their interests.")
    } else {
     interestGenerator.setup(people: people)
    }
  }
  
  func pairPeople() {
    let peoplePerUnsharedInterest = interestGenerator.getPeoplePerUnsharedInterest()
    pairManager.setup(people: people, peoplePerUnsharedInterest: peoplePerUnsharedInterest)
    pairs = pairManager.getPairs()
  }
  
  /// Display the output of pairing
  func displayPairs() {
    let sentence = pairs.isEmpty ? "\nThere is no pair." : "\nThe pairs are:\n"
    print(sentence)
    for pair in pairs {
      pair.displayInformation()
    }
    print("")
  }
  
  /// Display basic pieces of information concerning each person [unique name, job and interest(s)].
  func displayIntroduction() {
    if people.isEmpty || peopleNames.isEmpty { print("\nError: People have not been generated.") }
    for index in 0..<people.count {
      let name = peopleNames[index]
      let person = people[name]!
      print("\nInformation of player #\(index + 1):")
      print("\(name) : \(person.job)")
      person.displaySharedInterests()
    }
  }
}
