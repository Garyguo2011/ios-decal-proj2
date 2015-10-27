//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var currentGuess: UILabel!
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var newGameButton: UIBarButtonItem!
    @IBOutlet weak var tried: UILabel!

    var hangman = Hangman()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newGame()
    }

    func newGame(){
        hangman.start()
        currentGuess.text = hangman.knownString
        tried.text = "Welcome to Hangman"
        print(hangman.answer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickNewGame(sender: UIBarButtonItem) {
        newGame()
    }

    @IBAction func clickStartOver(sender: UIButton) {
        newGame()
    }
    
    @IBAction func makeAGuess(sender: UIButton) {
        guessTextField.text = guessTextField.text!.uppercaseString
        let firstChar = Array(arrayLiteral: guessTextField.text)[0]
        if(hangman.win()){
            return alertWin()

        }
        if(hangman.lose()){
            return alertLose()
        }
        let wrong = hangman.wrongTimes()
        hangman.guessLetter(firstChar!)
        if(hangman.wrongTimes() > wrong){
            let imageName = "hangman" + String(wrong+2) + ".gif"
            hangmanImage.image = UIImage(named: imageName)
            var wrongTried = "";
            for (var i = 0; i < hangman.wrongTimes(); i++){
                wrongTried += " " + String(hangman.wrongLetters![i])
            }
            tried.text = "Tried: " + wrongTried
        }
        self.view.endEditing(true)
        guessTextField.text = ""
        currentGuess.text = hangman.knownString
        if(hangman.win()){
            return alertWin()
        }
        if(hangman.lose()){
            return alertLose()
        }
    }
    
    func alertWin(){
        if(hangman.win()){
            let alertController = UIAlertController(title: "Winner", message:
                "You are win!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            return;
        }
    }
    
    func alertLose(){
        if (hangman.lose()){
            let alertController = UIAlertController(title: "Game Over", message:
                "You are Lose!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            return;
        }
    }
}

