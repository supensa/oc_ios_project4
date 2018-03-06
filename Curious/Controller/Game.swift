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
  private var noPairs: [Person]
  private var pairs: [Pair]
  
  init() {
    peopleGenerator.setup()
    people = peopleGenerator.getPeople()
    peopleNames = peopleGenerator.getPeopleNames()
    
    interestGenerator.setup(people: people)
    let peoplePerUnsharedInterest = interestGenerator.getPeoplePerUnsharedInterest()
    
    pairManager.setup(people: people, peoplePerUnsharedInterest: peoplePerUnsharedInterest)
    noPairs = pairManager.getNoPairs()
    pairs = pairManager.getPairs()
  }
  
  /// Display the output of creating and pairing people
  func output() {
    print("Welcome to the 'Curious Katie' app.\n")
    display(people: people, peopleNames: peopleNames)
    display(pairs: pairs, noPairs: noPairs)
  }
  
  /// Display the output of pairing
  ///
  /// - Parameters:
  ///   - pairs: people paired
  ///   - noPairs: people not paired
  private func display(pairs: [Pair], noPairs: [Person]) {
    let sentence = pairs.isEmpty ? "\nThere is no pair." : "\nThe pairs are:\n"
    print(sentence)
    display(pairs: pairs)
    if !pairs.isEmpty {
      display(noPairNames: noPairs)
    }
    print("")
  }
  
  /// Display the pairs
  ///
  /// - Parameter pairs: People paired with different interest(s)
  private func display(pairs: [Pair]) {
    for pair in pairs {
      print("\t\(pair.person.name) and \(pair.partner.name).\n\tTopic:")
      for interest in pair.interests {
        print("\t\t-> \(interest.title)")
      }
    }
  }
  
  ///  Display the people without any pair
  ///
  /// - Parameters:
  ///   - noPairs: List of people with no pair
  private func display(noPairNames: [Person]) {
    if !noPairNames.isEmpty {
      print("\nNo pair found for:\n")
      for person in noPairNames {
        print("\t-> \(person.name)")
      }
    }
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
