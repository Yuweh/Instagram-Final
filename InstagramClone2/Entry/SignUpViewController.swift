//
//  SignUpViewController.swift
//  InstagramClone2
//
//  Created by Francis Jemuel Bergonia on 05/05/2018.
//  Copyright © 2018 Francis Jemuel Bergonia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.backgroundColor = UIColor.clear
        usernameTextField.tintColor = UIColor.white
        usernameTextField.textColor = UIColor.white
        usernameTextField.attributedPlaceholder = NSAttributedString(string: usernameTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white:1.0, alpha: 0.6)])
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white:1.0, alpha: 0.6)])
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(white:1.0, alpha: 0.6)])
        
//        let bottomlayer = CALayer()
//        bottomlayer.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
//        bottomlayer.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
//        usernameTextField.layer.addSublayer(bottomlayer)
//        emailTextField.layer.addSublayer(bottomlayer)
//        passwordTextField.layer.addSublayer(bottomlayer)
        
        profileImage.layer.cornerRadius = 50
        profileImage.clipsToBounds = true
    }

    
    @IBAction func dismiss_OnClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {


        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Registration Successful and will be saved at keychain for \(user)")
                
                //Firebase Database
                let ref = Database.database().reference()
                let usersReference = ref.child("users")
                let uid = user?.uid
                let newUserReference = usersReference.child(uid!)
                newUserReference.setValue(["username": self.usernameTextField.text!, "email": self.emailTextField.text!])
                print("description \(newUserReference.description())")
            
            }
        }
    }
    
    
    

}
