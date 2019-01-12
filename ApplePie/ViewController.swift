//
//  ViewController.swift
//  ApplePie
//
//  Created by James Chun on 1/11/19.
//  Copyright © 2019 James Chun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords: [String] = [
        "effervescent",
        "stifling",
        "contrive",
        "jaded",
        "dissipate",
        "decimate",
        "buccaneer",
        "incandescent"
    ]

    let incorrectMovesAllowed: Int = 7
    var totalWins: Int = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses: Int = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newRound()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString: String = sender.title(for: .normal)!
        let letter: Character = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        print(currentGame.guessedLetters)
        print(currentGame.incorrectMovesRemaining)
        updateGameState()
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = true
        }
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord: String = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
        
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
        	updateUI()
        }
    }
    
    func updateUI() {
        var letters: [String] = []
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing: String = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins) Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    

}

