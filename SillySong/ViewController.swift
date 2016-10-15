//
//  ViewController.swift
//  Silly Song
//
//  Created by Emanuele Bartolomucci on 10/15/16.
//  Copyright © 2016 Emanuele Bartolomucci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!

    let lyricsTemplate =  ["<FULL_NAME>, <FULL_NAME>, Bo B<TRIMMED_NAME>\n" +
        "Banana Fana Fo F<TRIMMED_NAME>\n" +
        "Me My Mo M<TRIMMED_NAME>\n" +
    "<FULL_NAME>"].joinWithSeparator("\n")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        nameField.autocapitalizationType = .Words
        nameField.returnKeyType = .Done
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func fieldReset(sender: AnyObject) {
        nameField.text  = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(sender: AnyObject) {
        if let name = nameField.text {
            lyricsView.text = lyricsForName(lyricsTemplate, fullName: name)
        }
    }
}

func shortNameFromName(name: String) -> String {
    let lowercaseName = name.lowercaseString
    let vowelsArray = NSCharacterSet(charactersInString: "aeiou")
    if let initialVowel = lowercaseName.rangeOfCharacterFromSet(vowelsArray) {
        return lowercaseName.substringFromIndex(initialVowel.startIndex)
    }
    return lowercaseName
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(fullName)
    let tempTemplate = lyricsTemplate
    let fullNameTemplate = tempTemplate.stringByReplacingOccurrencesOfString("<FULL_NAME>", withString: fullName)
    let finalLyrics = fullNameTemplate.stringByReplacingOccurrencesOfString("<TRIMMED_NAME>", withString: shortName)
    return finalLyrics
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
