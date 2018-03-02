//
//  PairManager.swift
//  Curious
//
//  Created by Spencer Forrest on 21/02/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

/// Manager taking care of pairing people who don't have any interest in common
class PairManager {
  
  private var dictionaryNoPair = [String:Person]()
  private var dictionaryPairs = [String:Pair]()
  
  /// Pair people that do not share any common interest
  ///
  /// - Parameters:
  ///   - people: All the people to pair
  ///   - namesPerUnsharedInterestTitle: Key: Interest title and Value: dictionary of people
  func setup(people:[String:Person], peoplePerUnsharedInterestTitle: [String:Array<Person>]) {
    guard people.count > 0 else { return }
    dictionaryNoPair = people
    for (name, person) in people {
      let interests = person.getInterests()
      let dictionary = unshareInterestsByName(interests: interests, namesPerUnsharedInterestTitle: peoplePerUnsharedInterestTitle)
      pairing(name: name, people: people, dictionary: dictionary)
    }
  }
  
  /// Pair and their interest to discuss
  ///
  /// - Returns: Array of "Pair"
  func getPairs() -> [Pair] {
    return dictionaryPairs.map { $0.value }
  }
  
  /// All the names of the poeple without any pair
  ///
  /// - Returns: Array of names with no pair
  func getNoPairNames() -> [String] {
    var noPairNames = [String]()
    for (name, _) in dictionaryNoPair {
      noPairNames.append(name)
    }
    return noPairNames
  }
  
  /// Setup dictionary of pairs and list of names without pairs
  ///
  /// - Parameters:
  ///   - name: Name of the person to check
  ///   - people: key: person's name and value: person
  ///   - dictionary: key: person's name and value: Array of interest titles
  private func pairing(name: String, people: [String:Person], dictionary: [String:Array<Interest>]) {
    for (partnerName, interests) in dictionary {
      let partner = people[partnerName]!
      let person = people[name]!
      if let dictionary = dictionaryPairs[partnerName] {
        dictionary.addInterests(interests: interests)
      } else {
        dictionaryPairs[name] = Pair.init(person: person, partner: partner, interests: interests)
      }
      dictionaryNoPair.removeValue(forKey: person.name)
    }
  }
  
  /// Give us the name of the people that don't share those interests
  ///
  /// - Parameters:
  ///   - titles: Interest titles to check
  ///   - namesPerUnsharedInterestTitle: Key: title interest, value: Array people's names
  /// - Returns: Dictionary with key: person's name and value: Array of interest titles
  private func unshareInterestsByName(interests: [Interest], namesPerUnsharedInterestTitle: [String:Array<Person>]) -> [String:Array<Interest>] {
    var unshareInterestsByName = [String:Array<Interest>]()
    for interest in interests {
      guard let Partners = namesPerUnsharedInterestTitle[interest.title] else { continue }
      for partner in Partners {
        let partnerName = partner.name
        if unshareInterestsByName[partnerName] == nil { unshareInterestsByName[partnerName] = [Interest]() }
        unshareInterestsByName[partnerName]?.append(interest)
      }
    }
    return unshareInterestsByName
  }
}
