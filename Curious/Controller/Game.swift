//
//  Game.swift
//  Curious
//
//  Created by Spencer Forrest on 24/12/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

class Game {
  private var peopleManager = PeopleManager()

  
  func start() {
    
    print("Aloha !\nThis the 'Curious Katie' app.")
    
    // Introduction PART
    CreatePeople()
    
    // Display presentation PART
    displayPlayerIntroduction()
    
    print("\n- THE END -")
  }
  
  // Introduction PART
  private func CreatePeople() {
    peopleManager.generateRandom()
  }
  
  // Display presentation PART
  private func displayPlayerIntroduction() {
    peopleManager.displayIntroduction()
  }
}
