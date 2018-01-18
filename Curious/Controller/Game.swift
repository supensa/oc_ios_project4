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
    
    CreatePeople()
    
    displayPlayerIntroduction()
    
    print("\n- THE END -")
  }
  
  /// Introduction
  private func CreatePeople() {
    peopleManager.generateRandom()
  }
  
  /// Presentation
  private func displayPlayerIntroduction() {
    peopleManager.displayIntroduction()
  }
}
