//
//  Game.swift
//  Curious
//
//  Created by Spencer Forrest on 24/12/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

class Game {
  private var people: [Person] = [Person]()
  private let kNumberMaxInterests: UInt32 = 5
  private let kNumberMaxPlayers: UInt32 = 12
  
  func start() {
    
    print("Aloha !\nThis the 'Curious Katie' app.")
    
    // Introduction PART
    playersIntroduction()
    
    // Display presentation PART
    displayPlayerIntroduction()
    
    // Interests PART
    playersShareInterests()
    
    // Display interests PART
    displayInterest()
    
    // Generate pairs
    pairPlayers()
    
    print("\n- THE END -")
  }
  
  // Generate pairs
  private func pairPlayers() {
    
  }
  
  // Introduction PART
  private func playersIntroduction() {
    var countPlayers = Int(arc4random_uniform(kNumberMaxPlayers - 1) + 2)
    // Can be paired with different players. No need for even numbers.
    if countPlayers % 2 != 0 { countPlayers += 1 }
    let availableNames = AvailableNames()
    for _ in 1...countPlayers {
      let name = availableNames.popRandom()
      // TODO
      let jobTitle = Job().random()
      if let name = name {
        let person = Person(name: name, jobTitle: jobTitle)
        // Give people random max number of interests
        person.numberInterests = Int(arc4random_uniform(kNumberMaxInterests) + 1)
        people.append(person)
      }
    }
  }
  
  // Name PART
  private func getName(count: Int, uniqueNames: [String]) -> String {
    while true {
      print("\nPlayer #\(count), please enter your UNIQUE name:")
      if let line = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "").capitalized, line != "" {
        if line.range(of: "^[a-zA-Z]*$", options:.regularExpression) == nil {
          print("Your name MUST only have Letters.")
          continue
        }
        if uniqueNames.contains(line) {
          print("Your name is not UNIQUE.")
          continue
        }
        return line
      } else {
        print("You did not enter anything")
      }
    }
  }
  
  // Job PART
  func getJobTitle() -> String {
    while true{
      print("What is your job ?")
      if let line = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines).capitalized, line != "" {
        if line.range(of: "^[a-zA-Z ]*$", options:.regularExpression) == nil {
          print("Only letters should be in your job position.")
          continue
        }
        return line
      } else {
        print("You did not enter anything")
      }
    }
  }
  
  // Display presentation PART
  private func displayPlayerIntroduction() {
    for index in 0..<people.count {
      print("\nInformation of player #\(index+1):")
      print("\(people[index].name) : \(people[index].jobTitle)")
    }
  }
  
  // Interests PART
  func playersShareInterests() {
    var peopleReady = [Person]()
    // Chose a random person and give him a random interest
    while people.count > 0 {
      let personIndex = Int(arc4random_uniform(UInt32(people.count)))
      let person = people[personIndex]
      let interestIndex = Int(arc4random_uniform(UInt32(person.unsharedInterestTitles.count)))
      let title = person.unsharedInterestTitles.remove(at: interestIndex)
      // TODO
      let comment = Comment().random()
      let interest = Interest(title: title, comment: comment)
      person.sharedInterests[title] = interest
      // Make sure the random person does not go over max number of interests
      if person.numberInterests == person.sharedInterests.count {
        peopleReady.append(people.remove(at: personIndex))
      }
    }
    people = peopleReady
  }
  
  // Display interests PART
  func displayInterest() {
    for person in people {
      print("\nPlayer: \(person.name)")
      for (title, interest) in person.sharedInterests {
        print("\t--> \(title.rawValue):\n\t\t\(interest.comment)")
      }
    }
  }
}
