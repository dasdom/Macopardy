//
//  NameInputViewController.swift
//  Macopardy
//
//  Created by dasdom on 30/09/16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

protocol NameInputProtocol {
  func inputDone(with name: String) -> ()
}

class NameInputViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  var delegate: NameInputProtocol? = nil
  
  @IBAction func done(_ sender: AnyObject) {
    if let name = nameTextField.text {
      delegate?.inputDone(with: name)
    }
    dismiss(animated: true, completion: nil)
  }
}
