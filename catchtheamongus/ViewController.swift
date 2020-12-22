//
//  ViewController.swift
//  catchtheamongus
//
//  Created by Kaan Kıvırcık on 21.12.2020.
//

import UIKit

class ViewController: UIViewController {

    //Variables
    var score = 0
    var charArray = [UIImageView]()
    var timer = Timer()
    var counter = 0
    var hideTimer = Timer()
    var highScore = 0
    
    
    //Views
    @IBOutlet weak var char1: UIImageView!
    @IBOutlet weak var char2: UIImageView!
    @IBOutlet weak var char3: UIImageView!
    @IBOutlet weak var char4: UIImageView!
    @IBOutlet weak var char5: UIImageView!
    @IBOutlet weak var char6: UIImageView!
    @IBOutlet weak var char7: UIImageView!
    @IBOutlet weak var char8: UIImageView!
    @IBOutlet weak var char9: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //HighScore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        //Images Interaction True
        char1.isUserInteractionEnabled = true
        char2.isUserInteractionEnabled = true
        char3.isUserInteractionEnabled = true
        char4.isUserInteractionEnabled = true
        char5.isUserInteractionEnabled = true
        char6.isUserInteractionEnabled = true
        char7.isUserInteractionEnabled = true
        char8.isUserInteractionEnabled = true
        char9.isUserInteractionEnabled = true
        
        //Images Recognizer
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        //Images Add Recognizers
        char1.addGestureRecognizer(recognizer1)
        char2.addGestureRecognizer(recognizer2)
        char3.addGestureRecognizer(recognizer3)
        char4.addGestureRecognizer(recognizer4)
        char5.addGestureRecognizer(recognizer5)
        char6.addGestureRecognizer(recognizer6)
        char7.addGestureRecognizer(recognizer7)
        char8.addGestureRecognizer(recognizer8)
        char9.addGestureRecognizer(recognizer9)
        
        //Create Images Array
        charArray=[char1,char2,char3,char4,char5,char6,char6,char7,char8,char9]
        
        //Timer
        counter = 20
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(hideChar), userInfo: nil, repeats: true)
        hideChar()
    }
    
    //Score Table
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    //Image Hider
    @objc func hideChar(){
        for char in charArray{
            char.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(charArray.count-1)))
        charArray[random].isHidden = false
    }
    
    //Timer Label Table
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            for char in charArray{
                char.isHidden = true
            }
            
        //HighScore Label
        if self.score > self.highScore{
            self.highScore = self.score
            highScoreLabel.text = "Highscore: \(self.highScore)"
            UserDefaults.standard.set(self.highScore, forKey: "highscore")
        }
        
        //Alert
        let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){(UIAlertAction) in
                //Replay Function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 20
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.hideChar), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

