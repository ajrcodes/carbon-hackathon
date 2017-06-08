//
//  FirstUseViewController.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/7/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import UIKit

class FirstUseViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNum1: UITextField!
    @IBOutlet weak var phoneNum2: UITextField!
    @IBOutlet weak var phoneNum3: UITextField!
    
    
    // MARK: - IBActions
    
    @IBAction func getStartedPressed(_ sender: Any) {
        if firstName.text == "" || lastName.text == ""
            || phoneNum1.text!.characters.count < 3 || phoneNum2.text!.characters.count < 3 || phoneNum3.text!.characters.count < 4 {
            let alert = UIAlertController(title: "Warning!", message: "Please complete all the fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            // create and add user object to global list
            let currentUser = User(firstName: firstName.text!, lastName: lastName.text!, phoneNumber: getPhoneNumber())
            
            userGroup.users.append(currentUser)
            
            // save defaults in UserDefaults for future application launches
            UserDefaults.standard.set(firstName.text!, forKey: "firstName")
            UserDefaults.standard.set(lastName.text!, forKey: "lastName")
            UserDefaults.standard.set(getPhoneNumber(), forKey: "phoneNum")
            
            // reset inputs
            firstName.text = ""
            lastName.text = ""
            phoneNum1.text = ""
            phoneNum2.text = ""
            phoneNum3.text = ""
        }
    }
    
    
    // MARK: - Lifecycle
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check to see which text field triggered the event
        if textField.tag == 1 {
            guard let text = phoneNum1.text else { return true}
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 3
        }
        
        if textField.tag == 2 {
            guard let text = phoneNum2.text else { return true}
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 3
        }
        
        if textField.tag == 3 {
            guard let text = phoneNum3.text else { return true}
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 4
        }
        
        return true
    }
    
    func getPhoneNumber() -> String {
        return phoneNum1.text! + phoneNum2.text! + phoneNum3.text!
    }
    
    override func viewDidLoad() {
        if UserDefaults.standard.bool(forKey: "hasLaunched") == true {
            performSegue(withIdentifier: "createGroup", sender: nil)
        }
        
        phoneNum1.delegate = self
        phoneNum1.tag = 1
        
        phoneNum2.delegate = self
        phoneNum2.tag = 2
        
        phoneNum3.delegate = self
        phoneNum3.tag = 3
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
