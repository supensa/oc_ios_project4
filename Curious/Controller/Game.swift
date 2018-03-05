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
  private var noPairNames: [String]
  private var pairs: [Pair]
  
  init() {
    peopleGenerator.setup()
    people = peopleGenerator.getPeople()
    peopleNames = peopleGenerator.getPeopleNames()
    
    interestGenerator.setup(for: people)
    let namesPerUnsharedInterestTitle = interestGenerator.getnamesPerUnsharedInterestTitle()
    
    pairManager.setup(people: people, namesPerUnsharedInterestTitle: namesPerUnsharedInterestTitle)
    noPairNames = pairManager.getNoPairNames()
    pairs = pairManager.getPairs()
  }
  
  /// Display the output of creating and pairing people
  func output() {
    print("Welcome to the 'Curious Katie' app.\n")
    display(people: people, peopleNames: peopleNames)
    display(pairs: pairs, noPairNames: noPairNames)
  }
  
  /// Display the pairs and the people that could not be paired
  ///
  /// - Parameters:
  ///   - pairs: Represent pairs
  ///   - noPairs: people not paired
  private func display(pairs: [Pair], noPairNames: [String]) {
    let sentence = pairs.isEmpty ? "\nThere is no pair." : "\nThe pairs are:\n"
    print(sentence)
    display(pairs: pairs)
    if !pairs.isEmpty {
      display(noPairNames: noPairNames)
    }
    print("")
  }
  
  /// Display the pairs
  ///
  /// - Parameter pairs: Represent people paired with interests to talk about
  private func display(pairs: [Pair]) {
    for pair in pairs {
      print("\t\(pair.person.name) and \(pair.partner.name).\n\tTopic:")
      for interest in pair.interests {
        print("\t\t-> \(interest.title)")
      }
    }
  }
  
  ///  Display the people that could not be paired if any
  ///
  /// - Parameters:
  ///   - noPairs: List of people with no pair
  private func display(noPairNames: [String]) {
    if !noPairNames.isEmpty {
      print("\nNo pair found for:\n")
      for name in noPairNames {
        print("\t-> \(name)")
      }
    }
  }
  
  /// Display basic pieces of information concerning each person (unique name, job and interests).
  ///
  /// - Parameters:
  ///   - people: Dictionary of people
  ///   - peopleNames: Array of people name
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
