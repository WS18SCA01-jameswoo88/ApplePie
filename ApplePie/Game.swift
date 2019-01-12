//
//  Game.swift
//  ApplePie
//
//  Created by James Chun on 1/11/19.
//  Copyright © 2019 James Chun. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    var formattedWord: String {
        var guessedWord: String = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord.append(letter) //guessedWord += "\(letter)"
            } else {
                guessedWord.append("_") //guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) { //.characters.contain() is not needed. .characters deprecated.
            incorrectMovesRemaining -= 1
        }
    }
}
