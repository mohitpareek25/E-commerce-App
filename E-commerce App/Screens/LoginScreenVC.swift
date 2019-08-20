//
//  LoginScreenVC.swift
//  E-commerce App
//
//  Created by MOHIT PAREEK on 19/07/19.
//  Copyright © 2019 MOHIT PAREEK. All rights reserved.
//

import UIKit

class LoginScreenVC: UIViewController {

    // variables for credentials to log in
    let email = "abc@email.com"
    let password = "123456"
    
    // outlets
    
    @IBOutlet weak var emailOutlet: UITextField!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // action for login button
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if emailOutlet.text == email && passwordOutlet.text == password {
            print("credentials are true")
            
            UserDefaults.standard.set(emailOutlet.text, forKey: "email")
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "tabBarController")
            
            navigationController?.pushViewController(vc!, animated: true)
            
            
        } else{
            
            let alert = UIAlertController(title: "Alert", message: "Wrong Password or Email!", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            
            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
            
            
        }
        
    }
    
}
