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
      var differenceCountByName = [String:Int]()
      
      for title in titles{
        
        guard let potentialPairs = peopleForEachUnsharedInterestTitle[title] else { continue }
        
        for (namePotentialPair,_) in potentialPairs {
          if differenceCountByName[namePotentialPair] == nil {
            differenceCountByName[namePotentialPair] = 1
          } else {
            differenceCountByName[namePotentialPair]! += 1
          }
        }
      }
      
      for (namePotentialPair, totalDifference) in differenceCountByName {
        if titles.count == totalDifference {
          if pairs[name] == nil { pairs[name] = [String]() }
          pairs[name]?.append(namePotentialPair)
          noPairs.removeValue(forKey: name)
        }
      }
    }
  }
}
