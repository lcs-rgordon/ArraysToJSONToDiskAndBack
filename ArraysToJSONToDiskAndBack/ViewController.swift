//
//  ViewController.swift
//  ArraysToJSONToDiskAndBack
//
//  Created by Russell Gordon on 2020-05-07.
//  Copyright © 2020 Russell Gordon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldFirstName1: UITextField!
    @IBOutlet weak var textFieldLastName1: UITextField!
    @IBOutlet weak var textFieldFirstName2: UITextField!
    @IBOutlet weak var textFieldLastName2: UITextField!
    @IBOutlet weak var textFieldFirstName3: UITextField!
    @IBOutlet weak var textFieldLastName3: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Change return key type to "done" for each text field
        textFieldFirstName1.returnKeyType = .done
        textFieldFirstName2.returnKeyType = .done
        textFieldFirstName3.returnKeyType = .done
        textFieldLastName1.returnKeyType = .done
        textFieldLastName2.returnKeyType = .done
        textFieldLastName3.returnKeyType = .done
        
        // Make the delegate for all text fields be this view (the screen, or view, we are currently preparing to show)
        textFieldFirstName1.delegate = self
        textFieldFirstName2.delegate = self
        textFieldFirstName3.delegate = self
        textFieldLastName1.delegate = self
        textFieldLastName2.delegate = self
        textFieldLastName3.delegate = self

    }
    
    @IBAction func saveNames(_ sender: Any) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

