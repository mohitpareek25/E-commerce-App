//
//  ProfileVC.swift
//  E-commerce App
//
//  Created by MOHIT PAREEK on 10/07/19.
//  Copyright © 2019 MOHIT PAREEK. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!

    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    //MARK: variables declared
    var name = "Tim Cook"
    var des = " I love to buy Vinyls, iPads, and other tech gadgets"
    var isPickedBefore = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        nameLabel.text = name
        DescriptionLabel.text = des
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if defaults.bool(forKey: "isPickedBefore"){
            
            nameLabel.text = name
            DescriptionLabel.text = des
            descriptionTextField.isHidden = true
            nameTextField.isHidden = true
            editButton.isEnabled = true
            doneButton.isEnabled = false
            doneButton.tintColor = .clear
            editButton.tintColor = .white
            

        }
        else{
            editState()
        }
        
        nameLabel.text = name
        DescriptionLabel.text = des
    
    }
    
    // Mark : Action buttons

    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
        print("User Logged Out")
        UserDefaults.standard.removeObject(forKey: "email")
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC")
        let navVC = UINavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: true)
        let share = UIApplication.shared.delegate as? AppDelegate
        share?.window?.rootViewController = navVC
        share?.window?.makeKeyAndVisible()
        
        
    }
 

    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {

        editState()
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        doneState()
        
    }
    
    
    // Mark : Edit State
    func editState(){
        print("edit function")
        nameTextField.isHidden = false
        descriptionTextField.isHidden = false
        doneButton.isEnabled = true
        editButton.isEnabled = false
        doneButton.tintColor = .white
        editButton.tintColor = .clear
        
        isPickedBefore = false
        defaults.set(false, forKey: "isPickedBefore")
        
    }
    
    //MARK: Done state
    func doneState(){
        name = nameTextField.text!
        des = descriptionTextField.text!
        nameLabel.text = name
        DescriptionLabel.text = des
        descriptionTextField.isHidden = true
        nameTextField.isHidden = true
        editButton.isEnabled = true
        doneButton.isEnabled = false
        doneButton.tintColor = .clear
        editButton.tintColor = .white
        
        isPickedBefore = true
        defaults.set(true, forKey: "isPickedBefore")
        
    }

}
