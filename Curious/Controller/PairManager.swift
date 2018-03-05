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
  ///   - namesPerUnsharedInterestTitle: Key: Interest and Value: array of people
  func setup(people:[String:Person], namesPerUnsharedInterestTitle: [Interest:Array<Person>]) {
    guard people.count > 0 else { return }
    dictionaryNoPair = people
    for (_, person) in people {
      let interests = person.getInterests()
      for interest in interests {
        guard let partners = namesPerUnsharedInterestTitle[interest] else { continue }
        for partner in partners {
          updateNoPairs(name: person.name, partnerName: partner.name)
          let hasExistingPair = dictionaryPairs[partner] != nil
          updatePair(hasExistingPair: hasExistingPair, person: person, partner: partner, interests: [interest])
        }
      }
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
  
  /// Pair people or update their pair with topic(s) to discuss
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
}
