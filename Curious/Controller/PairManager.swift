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
  private var dictionaryPairs = [Person:[Person:Pair]]()
  
  /// Pair people that do not share any common interest
  ///
  /// - Parameters:
  ///   - people: All the people to pair
  ///   - namesPerUnsharedInterestTitle: Key: Interest title and Value: dictionary of people
  func setup(people:[String:Person], namesPerUnsharedInterestTitle: [Interest:Array<Person>]) {
    guard people.count > 0 else { return }
    dictionaryNoPair = people
    for (name, person) in people {
      let interests = person.getInterests()
      let unsharedPartnerInterestDictionary = unshareInterestsByName(interests: interests, namesPerUnsharedInterestTitle: namesPerUnsharedInterestTitle)
      pairing(name: name, people: people, unsharedPartnerInterestDictionary: unsharedPartnerInterestDictionary)
    }
  }
  
  /// All the pairs
  ///
  /// - Returns: Array of "Pair"
  func getPairs() -> [Pair] {
    var pairs = [Pair]()
    for dictionary in dictionaryPairs {
      let array = dictionary.value.map { $0.value }
      pairs.append(contentsOf: array)
    }
    return pairs
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
  ///   - unsharedPartnerInterestDictionary: key: person and value: Array of interest they do not share
  private func pairing(name: String, people: [String:Person], unsharedPartnerInterestDictionary: [Person:Array<Interest>]) {
    for (partner, interests) in unsharedPartnerInterestDictionary {
      let partnerName = partner.name
      let partner = people[partnerName]!
      let person = people[name]!
      
      updateNoPairs(name: name, partnerName: partnerName)
      
      let hasExistingPair = dictionaryPairs[partner] != nil
      updatePair(hasExistingPair: hasExistingPair, person: person, partner: partner, interests: interests)
    }
  }
  
  /// Pair people with topic(s) to discuss
  ///
  /// - Parameters:
  ///   - hasExistingPair: True if two people are already paired
  ///   - person: person to pair
  ///   - partner: partner of the person to pair
  ///   - interests: interests they will talk about
  private func updatePair(hasExistingPair: Bool, person: Person, partner: Person, interests: [Interest]) {
    let mainPersonName = hasExistingPair ? partner : person
    let secondaryPersonName = hasExistingPair ? person : partner
    
    if dictionaryPairs[mainPersonName] == nil {
      dictionaryPairs[mainPersonName] = [secondaryPersonName : Pair.init(person: person, partner: partner, interests: interests)]
    } else if dictionaryPairs[mainPersonName]![secondaryPersonName] == nil {
      dictionaryPairs[mainPersonName]![secondaryPersonName] = Pair.init(person: person, partner: partner, interests: interests)
    } else {
      dictionaryPairs[mainPersonName]![secondaryPersonName]?.addInterests(interests: interests)
    }
  }
  
  /// Remove people with a pair from the list of people with no pair
  ///
  /// - Parameters:
  ///   - name: name of a person
  ///   - partnerName: name of his/her pair
  private func updateNoPairs(name: String, partnerName: String) {
    dictionaryNoPair.removeValue(forKey: name)
    dictionaryNoPair.removeValue(forKey: partnerName)
  }
  
  /// Give us the name of the people that don't share those interests
  ///
  /// - Parameters:
  ///   - interests: Interests to check
  ///   - namesPerUnsharedInterestTitle: Key: interest, value: Array of people
  /// - Returns: Dictionary with key: person and value: Array of interests
  private func unshareInterestsByName(interests: [Interest], namesPerUnsharedInterestTitle: [Interest:Array<Person>]) -> [Person:Array<Interest>] {
    var unshareInterestsByName = [Person:Array<Interest>]()
    for interest in interests {
      guard let Partners = namesPerUnsharedInterestTitle[interest] else { continue }
      for partner in Partners {
        if unshareInterestsByName[partner] == nil { unshareInterestsByName[partner] = [Interest]() }
        unshareInterestsByName[partner]?.append(interest)
      }
    }
    return unshareInterestsByName
  }
}
