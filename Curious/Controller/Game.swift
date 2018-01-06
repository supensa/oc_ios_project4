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
    
    // Display
    
    print("\n- THE END -")
  }
  
  // Introduction PART
  private func playersIntroduction() {
    let countPlayers = Int(arc4random_uniform(kNumberMaxPlayers - 1) + 2)
    for _ in 1...countPlayers {
      let name = Name.getRandom()
      let jobTitle = Job.getRandom()
      if let name = name {
        people.append(Person(name: name, jobTitle: jobTitle))
      }
    }
  }
  
  //
  
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
    for _ in 0..<people.count {
      let personIndex = Int(arc4random_uniform(UInt32(people.count)))
      let interestCount = arc4random_uniform(kNumberMaxInterests) + 1
      let person = people.remove(at: personIndex)
      print("\nPlayer: \(person.name) - InterestCount: \(interestCount)")
      Comment.reload()
      
      for _ in 1...interestCount {
        let interestIndex = Int(arc4random_uniform(UInt32(person.unsharedInterests.count)))
        let kindInterest = person.unsharedInterests.remove(at: interestIndex)
        if let comment = Comment.getRandom() {
          let interest = Interest(title: kindInterest, comment: comment)
          person.sharedInterests[kindInterest] = interest
          print("Interest:\n \(interest.title.rawValue):\n \(interest.comment)")
        }
      }
      peopleReady.append(person)
    }
    people = peopleReady
  }
  
  // Display unshared interests
  func displayUnsharedInterest(person: Person) {
    if person.sharedInterests.count > 0 {
      print("\t--> #0: No additional interest")
    }
    let unsharedInterests = person.unsharedInterests
    for index in 0..<unsharedInterests.count {
      print("\t--> #\(index+1): \(unsharedInterests[index].rawValue)")
    }
  }
  
}
