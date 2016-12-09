//
//  AnswerViewController.swift
//  Macopardy
//
//  Created by dasdom on 24/09/16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

  var level: [String:String] = [:]
  var playerKeys: [String] = ["Foo", "Spieler 1", "Spieler 2", "Spieler 3", "Spieler 4"]
  var playerNames: [String:String] = ["Spieler 1":"Spieler 1", "Spieler 2":"Spieler 2", "Spieler 3":"Spieler 3", "Spieler 4":"Spieler 4"]
  
  @IBOutlet weak var answerLabel: UILabel!
  @IBOutlet weak var questionButton: UIButton!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var playerOneButton: UIButton!
  @IBOutlet weak var playerTwoButton: UIButton!
  @IBOutlet weak var playerThreeButton: UIButton!
  @IBOutlet weak var playerFourButton: UIButton!
  
  var counter = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    playerOneButton.backgroundColor = UIColor.playerOne
    playerTwoButton.backgroundColor = UIColor.playerTwo
    playerThreeButton.backgroundColor = UIColor.playerThree
    playerFourButton.backgroundColor = UIColor.playerFour
  
    if let name = playerNames[playerKeys[1]] {
      playerOneButton.setTitle(name, for: .normal)
    }
    if let name = playerNames[playerKeys[2]] {
      playerTwoButton.setTitle(name, for: .normal)
    }
    if let name = playerNames[playerKeys[3]] {
      playerThreeButton.setTitle(name, for: .normal)
    }
    if let name = playerNames[playerKeys[4]] {
      playerFourButton.setTitle(name, for: .normal)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let answer = level["answer"] {
      answerLabel.text = answer
      answerLabel.numberOfLines = 0
      imageView.isHidden = true
    }
    if let imageName = level["image"] {
      imageView.image = UIImage(named: imageName)
      answerLabel.isHidden = true
    }
  }
  
  @IBAction func showQuestion(_ sender: AnyObject) {
    if counter < 1 {
      questionButton.setTitle("Frage anzeigen?", for: .normal)
    } else if counter < 2 {
      questionButton.setTitle("Wirklich?", for: .normal)
    } else if let question = level["question"] {
      questionButton.setTitle(question, for: .normal)
      questionButton.titleLabel?.numberOfLines = 0
    }
    counter += 1
  }
  
  @IBAction func wrong(_ sender: AnyObject) {
    if let presenting = presentingViewController as? GameViewController {
      presenting.correctTag = 0
    }
    dismiss(animated: true, completion: nil)
  }

  @IBAction func correct(_ sender: AnyObject) {
    if let presenting = presentingViewController as? GameViewController {
      presenting.correctTag = sender.tag
    }
    dismiss(animated: true, completion: nil)
  }
  
}
