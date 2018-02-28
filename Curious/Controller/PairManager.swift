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
  private var dictionaryPairs = [String:[String]]()
  
  /// Pair = name of a person and names of his partner
  ///
  /// - Returns: Array of "Pair"
  func getPairs() -> [Pair] {
    var pairs = [Pair]()
    for (personName, pairNames) in dictionaryPairs {
      pairs.append(Pair(personName: personName, pairNames: pairNames))
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
  
  /// Pair people that do not share any common interest
  ///
  /// - Parameters:
  ///   - people: All the people to pair
  ///   - namesPerUnsharedInterestTitle: Key: Interest title and Value: dictionary of people
  func setup(people:[String:Person], namesPerUnsharedInterestTitle: [String:Array<String>]) {
    guard people.count > 0 else { return }
    dictionaryNoPair = people
    for (name, person) in people {
      let titles = person.getTitleInterests()
      let differenceCountDictionary = countDifferences(titles: titles, namesPerUnsharedInterestTitle: namesPerUnsharedInterestTitle)
      pairing(name: name, interestCount: titles.count, differenceCountDictionary: differenceCountDictionary)
    }
  }
  
  /// Setup dictionary of pairs and list of names without pairs
  ///
  /// - Parameters:
  ///   - name: Name of the person to check
  ///   - interestCount: Number of interests shared by the person to check
  ///   - differenceCountDictionary: Dictionary with key: person's name and value: count of unshared titles
  private func pairing(name: String, interestCount: Int, differenceCountDictionary: [String:Int]) {
    for (namePotentialPair, totalDifference) in differenceCountDictionary {
      if interestCount == totalDifference {
        if dictionaryPairs[name] == nil { dictionaryPairs[name] = [String]() }
        dictionaryPairs[name]?.append(namePotentialPair)
        dictionaryNoPair.removeValue(forKey: name)
      }
    }
  }
  
  /// Map people with count of unshared interests according to array of interest titles
  ///
  /// - Parameters:
  ///   - titles: Interest titles to check
  ///   - namesPerUnsharedInterestTitle: Key: title interest, value: dictionary of people
  /// - Returns: Dictionary with key: person's name and value: count of unshared titles
  private func countDifferences(titles: [String], namesPerUnsharedInterestTitle: [String:Array<String>]) -> [String:Int] {
    var differenceCountDictionary = [String:Int]()
    for title in titles {
      guard let potentialPairs = namesPerUnsharedInterestTitle[title] else { continue }
      for namePotentialPair in potentialPairs {
        if differenceCountDictionary[namePotentialPair] == nil {
          differenceCountDictionary[namePotentialPair] = 1
        } else {
          differenceCountDictionary[namePotentialPair]! += 1
        }
      }
    }
    return differenceCountDictionary
  }
}
