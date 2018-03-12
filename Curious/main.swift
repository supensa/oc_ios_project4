//
//  main.swift
//  Curious
//
//  Created by Spencer Forrest on 24/12/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation

let game = Game()

// Introduction part
game.generatePeople()
game.generatePeopleInterests()
game.displayIntroduction()

// Pairing part
game.pairPeople()
game.displayPairs()
