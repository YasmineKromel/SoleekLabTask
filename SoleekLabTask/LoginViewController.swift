//
//  LoginViewController.swift
//  SoleekLabTask
//
//  Created by mino on 10/17/18.
//  Copyright © 2018 mino. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class LoginViewController: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet weak var Mail: UITextField!
    @IBOutlet weak var Password: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.Mail.delegate = self
        self.Password.delegate = self
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func Login(_ sender: UIButton) {
        
        if self.Mail.text == "" || self.Password.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.Mail.text!, password: self.Password.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                   // print("You have successfully logged in")
                    
                    //Go to the ListOfCountries if the login is sucessful
                  //  let ListOfCountriesViewController = CountriesListViewController()
                  //  self.present(ListOfCountriesViewController, animated: true, completion: nil)
                    
                    
                    let next = self.storyboard?.instantiateViewController(withIdentifier: "ListOfCounries") as! CountriesListViewController
                    self.navigationController?.pushViewController(next, animated: true)

                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
      
        
    }
    
    
    @IBAction func Register(_ sender: UIButton) {
        
        
    }
    
    
    //this function is fetching the json from URL
//func getJsonFromUrl(){
//        //creating a NSURL
//    
//    guard let url = URL(string: Url) else {
//        print("url error")
//        return
//    }
//        
//        //fetching the data from the url
//        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) -> Void in
//            
//            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
//                
//                //printing the json in console
//                print(jsonObj)
//                
//                //getting the avengers tag array from json and converting it to NSArray
//                if let CountriesArray = jsonObj!.value(forKey: "name") as? NSArray {
//                    //looping through all the elements
//                    for country in CountriesArray {
//                        
//                        //converting the element to a dictionary
//                        if let CountryDict = country as? NSDictionary {
//                            
//                            //getting the name from the dictionary
//                            if let CounryName = CountryDict.value(forKey:"name") {
//                                
//                                //adding the name to the array
//                                self.countries.append((CounryName as? String)!)
//                            }
//                            
//                        }
//                    }
//                }
//                
//                OperationQueue.main.addOperation({
//                    //calling another function after fetching the json
//                    //it will show the names to label
//                   // self.showNames()
//                })
//            }
//        }).resume()
//    }
//

    func FetchCountries()
    {
    }
    
    

    @IBAction func BB(_ sender: UIButton) {
       // allCountries()
      // FetchCountries()
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
