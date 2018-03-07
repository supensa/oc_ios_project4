//
//  PairManager.swift
//  Curious
//
//  Created by Spencer Forrest on 21/02/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

/// Manager taking care of pairing people who don't have interests in common
class PairManager {
  
  private var pairDictionary = [Person:[Person:Pair]]()
  
  /// All the people paired
  ///
  /// - Returns: Array of "Pair"
  func getPairs() -> [Pair] {
    var pairs = [Pair]()
    for dictionary in pairDictionary {
      let array = dictionary.value.map { $0.value }
      pairs.append(contentsOf: array)
    }
    return pairs
  }
  
  /// Setup the pairing mechanism
  ///
  /// - Parameters:
  ///   - people: All the people to pair
  ///   - peoplePerUnsharedInterest: Key: interest and Value: people who don't share the interest
  func setup(people:[String:Person], peoplePerUnsharedInterest: [Interest:Array<Person>]) {
    guard people.count > 0 else { return }
    for (_, person) in people {
      let interests = person.getInterests()
      for interest in interests {
        guard let partners = peoplePerUnsharedInterest[interest] else { continue }
        for partner in partners {
          pairPeople(person: person, partner: partner, interest: interest)
        }
      }
    }
  }
  
  /// Update a data structure for people with pairs
  ///
  /// - Parameters:
  ///   - person: person to pair
  ///   - partner: partner who will be paired with the person
  ///   - interest: interest that the person has but not the partner
  private func pairPeople(person: Person, partner: Person, interest: Interest) {
    let hasExistingPair = pairDictionary[partner] != nil
    updatePair(hasExistingPair: hasExistingPair, person: person, partner: partner, interests: [interest])
  }
  
  /// Pair people or update their pair with interest(s) to discuss
  ///
  /// - Parameters:
  ///   - hasExistingPair: True if two people are already paired
  ///   - person: person to pair
  ///   - partner: partner to be paired with the person
  ///   - interests: interests they will talk about
  private func updatePair(hasExistingPair: Bool, person: Person, partner: Person, interests: [Interest]) {
    let mainPersonName = hasExistingPair ? partner : person
    let secondaryPersonName = hasExistingPair ? person : partner
    
    if pairDictionary[mainPersonName] == nil {
      pairDictionary[mainPersonName] = [secondaryPersonName : Pair.init(person: person, partner: partner, interests: interests)]
    } else if pairDictionary[mainPersonName]![secondaryPersonName] == nil {
      pairDictionary[mainPersonName]![secondaryPersonName] = Pair.init(person: person, partner: partner, interests: interests)
    } else {
      pairDictionary[mainPersonName]![secondaryPersonName]?.addInterests(interests: interests)
    }
  }
}
