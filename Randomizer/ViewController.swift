//
//  ViewController.swift
//  Randomizer
//
//  Created by Robert Thompson on 10/10/16.
//  Copyright © 2016 Robert Thompson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var inputField_a: UITextField!
    @IBOutlet weak var inputField_b: UITextField!
    @IBOutlet weak var inputField_c: UITextField!
    @IBOutlet weak var inputField_d: UITextField!

    var textFields = [UITextField]()
    var textOptions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        textFields.append(inputField_a)
        textFields.append(inputField_b)
        textFields.append(inputField_c)
        textFields.append(inputField_d)
        
        for field in textFields {
            field.delegate = self
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func doTheRandom(_ sender: AnyObject) {
        resultLabel.textColor = UIColor.black
        resultLabel.text = "..."
        
        textOptions = []
        
        for field in textFields {
            if !(field.text?.isEmpty == true){
                textOptions.append(field.text!)
            }
        }
        
        if(textOptions.count <= 0){
            resultLabel.text = "Nothing to randomize!"
            return
        }
        
        let index = arc4random_uniform(UInt32(textOptions.count))
        let txt = textOptions[Int(index)]
        resultLabel.textColor = generateRandomColor()
        resultLabel.text = txt
    }

    @IBAction func Reset(_ sender: AnyObject) {
        for field in textFields {
            field.text = ""
        }
        resultLabel.textColor = UIColor.black
        resultLabel.text = "..."
    }
    
    //https://gist.github.com/asarode/7b343fa3fab5913690ef
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }

}

