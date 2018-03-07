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
  
  private var people: [String:Person]
  private var peopleNames: [String]
  private var pairs: [Pair]
  
  init() {
    peopleGenerator.setup()
    people = peopleGenerator.getPeople()
    peopleNames = peopleGenerator.getPeopleNames()
    
    interestGenerator.setup(people: people)
    let peoplePerUnsharedInterest = interestGenerator.getPeoplePerUnsharedInterest()
    
    pairManager.setup(people: people, peoplePerUnsharedInterest: peoplePerUnsharedInterest)
    pairs = pairManager.getPairs()
  }
  
  /// Display the output of creating and pairing people
  func output() {
    print("Welcome to the 'Curious Katie' app.\n")
    display(people: people, peopleNames: peopleNames)
    display(pairs: pairs)
  }
  
  /// Display the output of pairing
  ///
  /// - Parameters:
  ///   - pairs: people paired
  private func display(pairs: [Pair]) {
    let sentence = pairs.isEmpty ? "\nThere is no pair." : "\nThe pairs are:\n"
    print(sentence)
    for pair in pairs {
      pair.displayInformation()
    }
    print("")
  }
  
  /// Display basic pieces of information concerning each person [unique name, job and interest(s)].
  ///
  /// - Parameters:
  ///   - people: Dictionary of people
  ///   - peopleNames: Array of people's name
  private func display(people: [String:Person], peopleNames: [String]) {
    for index in 0..<people.count {
      let name = peopleNames[index]
      let person = people[name]!
      print("\nInformation of player #\(index + 1):")
      print("\(name) : \(person.job)")
      person.displaySharedInterests()
    }
  }
}
