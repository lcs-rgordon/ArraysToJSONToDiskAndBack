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
    
    // The empty array of names to store
    var people: [Person] = []
    
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
        
        // Watch for when the keyboard is shown or hidden
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)


    }
    
    @IBAction func saveNames(_ sender: Any) {
        
        // Write to the array of persons
        
        // First person
        if let first = textFieldFirstName1.text, let last = textFieldLastName1.text {
            people.append( Person(firstName: first, lastName: last) )
        }

        // Second person
        if let first = textFieldFirstName2.text, let last = textFieldLastName2.text {
            people.append( Person(firstName: first, lastName: last) )
        }

        // third person
        if let first = textFieldFirstName3.text, let last = textFieldLastName3.text {
            people.append( Person(firstName: first, lastName: last) )
        }
        
        // Try to encode the information in JSON
        if let encodedData = try? JSONEncoder().encode(people) {
            
            // If the data was encoded successfully, write it to the debug console
            let stringJSON = String(data: encodedData, encoding: .utf8)!
            print(stringJSON)
            
            // Now obtain a reference to the app bundle where this data can be saved
            let filename = getDocumentsDirectory().appendingPathComponent("names.json")

            do {
                try stringJSON.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
            
        }

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // Move the view up if the keyboard obscures the text field
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                // Only move view up if it's the last two fields the user has tapped into
                if textFieldFirstName3.isFirstResponder || textFieldLastName3.isFirstResponder {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}

