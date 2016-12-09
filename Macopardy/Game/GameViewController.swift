//
//  GameViewController.swift
//  Macopardy
//
//  Created by dasdom on 24/09/16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit
import CoreBluetooth

final class GameViewController: UIViewController {
  
  var categories: [[String:Any]] = []
  var correctTag: Int? = nil
  private var scores: [String:[String:[Int]]] = [:]
  var currentSelectedUser: Int? = nil
  var playerKeys: [String] = ["Foo", "Spieler 1", "Spieler 2", "Spieler 3", "Spieler 4"]
  var playerNames: [String:String] = ["Spieler 1":"Spieler 1", "Spieler 2":"Spieler 2", "Spieler 3":"Spieler 3", "Spieler 4":"Spieler 4"]
  
  fileprivate var centralManager: CBCentralManager? = nil
  fileprivate var peripherals: [CBPeripheral] = []
  fileprivate let uuid = CBUUID(string: "44D1AC91-1D21-4383-959E-98A5E45460AA")
  
  @IBOutlet weak var label0: UILabel!
  @IBOutlet weak var label1: UILabel!
  @IBOutlet weak var label2: UILabel!
  @IBOutlet weak var label3: UILabel!
  
  @IBOutlet weak var playerOneButton: UIButton!
  @IBOutlet weak var playerTwoButton: UIButton!
  @IBOutlet weak var playerThreeButton: UIButton!
  @IBOutlet weak var playerFourButton: UIButton!
  
  var currentSelectedButton: UIButton? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //    centralManager = CBCentralManager(delegate: self, queue: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let labels = [label0, label1, label2, label3]
    for (index, categoryDict) in categories.enumerated() {
      //      print("index: \(index), categoryDict: \(categoryDict)")
      if let name = categoryDict["name"] as? String {
        labels[index]?.text = name
      }
    }
    
    playerOneButton.backgroundColor = UIColor.playerOne
    playerTwoButton.backgroundColor = UIColor.playerTwo
    playerThreeButton.backgroundColor = UIColor.playerThree
    playerFourButton.backgroundColor = UIColor.playerFour
    
    defer {
      self.correctTag = nil
      self.currentSelectedButton = nil
    }
    
    guard let correctTag = correctTag else { return }
    guard let currentSelectedButton = currentSelectedButton else { return }
    let category = categories[currentSelectedButton.tag]
    guard let categoryName = category["name"] as? String else { fatalError() }
    guard let buttonText = currentSelectedButton.titleLabel?.text else { fatalError() }
    guard let buttonValue = Int(buttonText) else { fatalError() }
    
    var playerKey: String? = nil
    
    switch correctTag {
    case 1:
      currentSelectedButton.backgroundColor = UIColor.playerOne
    case 2:
      currentSelectedButton.backgroundColor = UIColor.playerTwo
    case 3:
      currentSelectedButton.backgroundColor = UIColor.playerThree
    case 4:
      currentSelectedButton.backgroundColor = UIColor.playerFour
    default:
      currentSelectedButton.backgroundColor = UIColor.black
    }
    
    playerKey = playerKeys[correctTag]
    if let thePlayerKey = playerKey {
      var playerScores = scores[thePlayerKey] ?? [String:[Int]]()
      var categoryScores = playerScores[categoryName] ?? [Int]()
      categoryScores.append(buttonValue)
      playerScores[categoryName] = categoryScores
      scores[thePlayerKey] = playerScores
    }
    
    for (playerKey, playerScores) in scores {
      var totalPlayerScore = 0
      for (_, categoryScores) in playerScores {
        totalPlayerScore += categoryScores.reduce(0, +)
      }
      
      if let playerName = playerNames[playerKey] {
        let labelText = "\(playerName): \(totalPlayerScore)"
        switch playerKey {
        case playerKeys[1]:
          playerOneButton.setTitle(labelText, for: .normal)
        case playerKeys[2]:
          playerTwoButton.setTitle(labelText, for: .normal)
        case playerKeys[3]:
          playerThreeButton.setTitle(labelText, for: .normal)
        case playerKeys[4]:
          playerFourButton.setTitle(labelText, for: .normal)
        default:
          break
        }
      }
    }
    
    currentSelectedUser = nil
  }
  
  @IBAction func show23(_ sender: UIButton) {
    currentSelectedButton = sender
    showLevel(for: sender.tag, with: "23")
  }
  
  @IBAction func show42(_ sender: UIButton) {
    currentSelectedButton = sender
    showLevel(for: sender.tag, with: "42")
  }
  
  @IBAction func show65(_ sender: UIButton) {
    currentSelectedButton = sender
    showLevel(for: sender.tag, with: "65")
  }
  
  @IBAction func show107(_ sender: UIButton) {
    currentSelectedButton = sender
    showLevel(for: sender.tag, with: "107")
  }
  
  func showLevel(for tag: Int, with name: String) {
    guard categories.count > tag else { print("error: not enough categories"); return }
    let level = categories[tag][name]
    performSegue(withIdentifier: "showAnswer", sender: level)
  }
  
  @IBAction func showNameInput(_ sender: UIButton) {
    currentSelectedUser = sender.tag
    performSegue(withIdentifier: "nameInput", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showAnswer" {
      guard let level = sender as? [String:String] else { print("sender is not a [String:String]"); return }
      let next = segue.destination as? AnswerViewController
      next?.level = level
      next?.playerKeys = playerKeys
      next?.playerNames = playerNames
    } else if segue.identifier == "nameInput" {
      let next = segue .destination as? NameInputViewController
      next?.delegate = self
    }
  }
}

extension GameViewController: NameInputProtocol {
  func inputDone(with name: String) {
    if let currentSelectedUser = currentSelectedUser {
      playerNames[playerKeys[currentSelectedUser]] = name
      switch currentSelectedUser {
      case 1:
        playerOneButton.setTitle(name, for: .normal)
      case 2:
        playerTwoButton.setTitle(name, for: .normal)
      case 3:
        playerThreeButton.setTitle(name, for: .normal)
      case 4:
        playerFourButton.setTitle(name, for: .normal)
      default:
        break
      }
    }
  }
}
