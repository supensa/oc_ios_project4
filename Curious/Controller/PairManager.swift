//
//  PairManager.swift
//  Curious
//
//  Created by Spencer Forrest on 21/02/2018.
//  Copyright © 2018 Spencer Forrest. All rights reserved.
//

import Foundation

class PairManager {
  
  private var noPairs = [String:Person]()
  private var pairs = [String:[String]]()
  
  func getNoPairs() -> [String:Person] {
    return noPairs
  }
  
  func getPairs() -> [String:[String]] {
    return pairs
  }
  
  /// Pair people that do not share any common interest
  ///
  /// - Parameters:
  ///   - people: All the people to pair
  ///   - peopleForEachUnsharedInterestTitle: Key: Interest title and Value: dictionary of people
  func setup(people:[String:Person], peopleForEachUnsharedInterestTitle: [String:[String:Person]]) {
    guard people.count > 0 else { return }
    noPairs = people
    for (name,_) in people {
      guard let titles = people[name]?.getTitleInterests() else { continue }
      let differenceCountDictionary = countDifference(titles: titles, peopleForEachUnsharedInterestTitle: peopleForEachUnsharedInterestTitle)
      pairing(name: name, interestCount: titles.count, differenceCountDictionary: differenceCountDictionary)
    }
  }
  
  /// Setup dictionary of pairs and list of names without pairs
  ///
  /// - Parameters:
  ///   - name: Name of the person to check
  ///   - titleCount: Number of interests shared by the person to check
  ///   - differenceCountDictionary: Dictionary with key: person's name and value: count of unshared titles
  private func pairing(name: String, interestCount: Int, differenceCountDictionary: [String:Int]) {
    for (namePotentialPair, totalDifference) in differenceCountDictionary {
      if interestCount == totalDifference {
        if pairs[name] == nil { pairs[name] = [String]() }
        pairs[name]?.append(namePotentialPair)
        noPairs.removeValue(forKey: name)
      }
    }
  }
  
  /// Map people with count of unshared interest according to array of interest titles
  ///
  /// - Parameters:
  ///   - titles: Interest titles to check
  ///   - peopleForEachUnsharedInterestTitle: Key: title interest, value: dictionary of people
  /// - Returns: Dictionary with key: person's name and value: count of unshared titles
  private func countDifference(titles: [String],peopleForEachUnsharedInterestTitle: [String:[String:Person]] ) -> [String:Int] {
    var differenceCountDictionary = [String:Int]()
    for title in titles{
      guard let potentialPairs = peopleForEachUnsharedInterestTitle[title] else { continue }
      for (namePotentialPair,_) in potentialPairs {
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
