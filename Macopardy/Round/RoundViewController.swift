//
//  RoundViewController.swift
//  Macopardy
//
//  Created by dasdom on 24/09/16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

class RoundViewController: UIViewController {
  
  @IBAction func showRound(_ sender: AnyObject) {
    print("tag: \(sender.tag)")
    performSegue(withIdentifier: "showRound", sender: sender)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showRound" {
      guard let button = sender as? UIButton else { print("sender is not a UIButton"); return }
      var plistName = ""
      switch button.tag {
      case 0:
        plistName = "round1"
      default:
        break
      }

      guard let url = Bundle.main.url(forResource: plistName, withExtension: "plist") else { print("url of plist not found"); return }
      do {
        let data = try Data(contentsOf: url)
        guard let categories = (try PropertyListSerialization.propertyList(from: data, options: [], format: nil)) as? [[String:Any]] else { print("categories could not be casted"); return }
        
        let next = segue.destination as! GameViewController
        next.categories = categories
      } catch {
        print(error)
      }
    }
  }
  
}
