//
//  ViewController.swift
//  EmojiMatch
//
//  Created by Sergio Blanco on 12/2/18.
//  Copyright © 2018 Sergio Blanco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var wordsArrayList = ["Exploding", "Shushing", "Squinting", "Sweating"]
    var imagesArrayList = ["Exploding", "Shushing", "Squinting", "Sweating"]
    var imageNameButton = [String: UIButton]()
    var imageTagName = [Int: String]()
    var highScore = 0
    var score = 0 {
        didSet {
            if score > highScore{
                highScore = score
                scoreLabel.textColor = UIColor.orange
                scoreLabel.text = " Score: \(score) \n NEW HIGHSCORE!"
            }
            else{
                scoreLabel.text = " Score: \(score)"
            }
        }
    }
    var matches = 0 {
        didSet {
            if matches == wordsArrayList.count{
                newGameButton.isEnabled = true
                encourageMessageLabel.textColor = UIColor.brown
                encourageMessageLabel.text = "Final score: \(score)"
                helpButton.isEnabled = false
            }
        }
    }
    var currentSelection: currentGame!
    
    @IBOutlet var emojiImagesButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var displayedWordLabel: UILabel!
    @IBOutlet weak var counterWordLabel: UILabel!
    @IBOutlet weak var encourageMessageLabel: UILabel!
    @IBOutlet weak var emojiButton11: UIButton!
    @IBOutlet weak var emojiButton12: UIButton!
    @IBOutlet weak var emojiButton13: UIButton!
    @IBOutlet weak var emojiButton14: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var wordCounter: UILabel!
    @IBOutlet weak var helpButton: UIButton!
    
    @IBAction func nextLevelButton(_ sender: Any) {
        encourageMessageLabel.textColor = UIColor.brown
        encourageMessageLabel.text = "COMMING SOON..."
    }
    
    @IBAction func helpButton(_ sender: Any) {
        encourageMessageLabel.textColor = UIColor.brown
        encourageMessageLabel.text = "Select the Emoji that best represents the word"
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        newRound()
    }
    
    @IBAction func emojiSelected(_ sender: UIButton) {
        let imageTouched = imageTagName[sender.tag]
        currentSelection.matching(imageTouched: imageTouched!, wordDisplayed:  currentSelection.wordRandomize)
        if currentSelection.matched {
            sender.setImage(UIImage(named: imageTouched! + "Right"), for: UIControlState.normal)
            sender.isEnabled = false
        }
        else{
            let imageButtonCorrect = imageNameButton[currentSelection.wordRandomize[0]]
            imageButtonCorrect?.setImage(UIImage(named: "Wrong"), for: UIControlState.normal)
            imageButtonCorrect?.isEnabled = false
        }
        updateGameState()
        
    }
    
    func updateGameState() {
        if currentSelection.matched{
            score += 1
            currentSelection.wordRandomize.removeFirst()
            currentSelection.matched = false
            encourageMessageLabel.textColor = UIColor.green
            encourageMessageLabel.text = "Correct!"
            matches += 1
            if (matches != 4){
                displayedWordLabel.text = currentSelection.wordRandomize[0]
                wordCounter.text = "\(matches+1) of 4"
            }
        }
        else{
            currentSelection.wordRandomize.removeFirst()
            encourageMessageLabel.textColor = UIColor.red
            encourageMessageLabel.text = "Incorrect!"
            matches += 1
            if (matches != 4){
                displayedWordLabel.text = currentSelection.wordRandomize[0]
                wordCounter.text = "\(matches+1) of 4"
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound() {
        matches = 0
        score = 0
        encourageMessageLabel.text = "Best Score: \(highScore)"
        updateUI()
    }
    
    func updateUI() {
        scoreLabel.textColor = UIColor.white
        scoreLabel.text = " Score: 0"
        newGameButton.isEnabled = false
        helpButton.isEnabled = true
        wordCounter.text = "1 of 4"
        
        var imageRandomize = randomize(array: imagesArrayList)
        
        imageNameButton = [imageRandomize[0]: emojiButton11, imageRandomize[1]: emojiButton12, imageRandomize[2]: emojiButton13, imageRandomize[3]: emojiButton14]
        
        for (imageRandom, buttonNumber) in imageNameButton{
            buttonNumber.setImage(UIImage(named: imageRandom), for: UIControlState.normal)
            imageTagName[buttonNumber.tag] = imageRandom
            buttonNumber.isEnabled = true
        }
        
        wordDisplayed()
    }
    
    func wordDisplayed() {
        let wordRandomize = randomize(array: wordsArrayList)
        currentSelection = currentGame(wordRandomize: wordRandomize, imageTouched: "", matched: false)
        displayedWordLabel.text = currentSelection.wordRandomize[0]
    }
    
    func randomize(array: [String]) -> [String] {
        var arrayToRamdomize = array
        var randomArray: [String] = []
        
        while arrayToRamdomize.isEmpty == false {
            
            let randomIndex = Int(arc4random_uniform(UInt32(arrayToRamdomize.count)))
            let randomObject = arrayToRamdomize.remove(at: randomIndex)
            randomArray.append(randomObject)
        }
        return randomArray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

