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
  private var peopleForEachUnsharedInterestTitle: [String:Dictionary<String,Person>]
  private var noPairs: [String:Person]
  private var pairs: [String:Array<String>]
  
  init() {
    peopleGenerator.setup()
    people = peopleGenerator.getPeople()
    peopleNames = peopleGenerator.getPeopleNames()
    
    interestGenerator.setup(for: people)
    peopleForEachUnsharedInterestTitle = interestGenerator.getPeopleForEachUnsharedInterestTitle()
    
    pairManager.setup(people: people, peopleForEachUnsharedInterestTitle: peopleForEachUnsharedInterestTitle)
    noPairs = pairManager.getNoPairs()
    pairs = pairManager.getPairs()
  }
  
  /// Display the output of creating and pairing people
  func output() {
    print("Welcome to the 'Curious Katie' app.\n")
    display(people: people, peopleNames: peopleNames)
    display(pairs: pairs, noPairs: noPairs)
  }
  
  /// Display the pairs and the people that could not be paired
  ///
  /// - Parameters:
  ///   - pairs: Represent people paired
  ///   - noPairs: List of people with no pair
  private func display(pairs: [String:[String]], noPairs: [String:Person]?) {
    let sentence = pairs.isEmpty ? "\nThere is no pair." : "\nThe pairs are:\n"
    print(sentence)
    display(pairs: pairs)
    if !pairs.isEmpty {
      display(noPairs: noPairs)
    }
    print("\n")
  }
  
  /// Display the pairs
  ///
  /// - Parameter pairs: Represent people paired
  private func display(pairs: [String:[String]]) {
    for (name, array) in pairs {
      print("\t\(name) with:")
      for pair in array {
        print("\t\t-> \(pair)")
      }
    }
  }
  
  ///  Display the people that could not be paired if any
  ///
  /// - Parameters:
  ///   - noPairs: List of people with no pair
  private func display(noPairs: [String:Person]?) {
    if let noPairs = noPairs, !noPairs.isEmpty {
      print("\nNo pair found for:\n")
      for (name,_) in noPairs {
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
      print("\(person.name) : \(person.job)")
      person.displaySharedInterests()
    }
  }
}
