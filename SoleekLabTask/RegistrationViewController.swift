//
//  RegistrationViewController.swift
//  SoleekLabTask
//
//  Created by mino on 10/17/18.
//  Copyright © 2018 mino. All rights reserved.
//

import UIKit
import  Firebase
import FirebaseAuth


class RegistrationViewController: UIViewController ,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Pass: UITextField!
    @IBOutlet weak var ConfirmPass: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Email.delegate = self
        self.ConfirmPass.delegate = self
        self.Pass.delegate = self 

        // Do any additional setup after loading the view.
    }
    
     func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func Register(_ sender: UIButton) {
        if Email.text == "" || self.Pass.text == "" || self.ConfirmPass.text == ""{
            let alertController = UIAlertController(title: "Error", message: "Some Fields Seemes Empty Please Fill ", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            if self.Pass.text == self.ConfirmPass.text{
                
                Auth.auth().createUser(withEmail: Email.text!, password: Pass.text!) { (user, error) in
                    
                    if error == nil {
                        
                        let alertLogin = UIAlertController(title: "Registration", message: "You have successfully Registered", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler:{ _ -> Void in
                              self.navigationController?.popViewController(animated: true)
                            })
                        alertLogin.addAction(defaultAction)
                        
                        self.present(alertLogin, animated: true, completion: nil)                        
                        
                        //print("You have successfully signed up")
                        
                    }
                        
                    else {
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                    
                }
            }
            else{
                
                let alertController = UIAlertController(title: "Error", message: "Check if password is confirmed correctly", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                present(alertController, animated: true, completion: nil)
                
            }

                
        }
            
       
        
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
