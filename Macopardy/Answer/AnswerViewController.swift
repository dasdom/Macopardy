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
 
  @IBOutlet weak var answerLabel: UILabel!
  @IBOutlet weak var questionButton: UIButton!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var playerOneButton: UIButton!
  @IBOutlet weak var playerTwoButton: UIButton!
  @IBOutlet weak var playerThreeButton: UIButton!
  @IBOutlet weak var playerFourButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    playerOneButton.backgroundColor = UIColor.playerOne
    playerTwoButton.backgroundColor = UIColor.playerTwo
    playerThreeButton.backgroundColor = UIColor.playerThree
    playerFourButton.backgroundColor = UIColor.playerFour
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
    if let question = level["question"] {
      questionButton.setTitle(question, for: .normal)
      questionButton.titleLabel?.numberOfLines = 0
    }
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
