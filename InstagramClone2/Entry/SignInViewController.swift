//
//  SignInViewController.swift
//  InstagramClone2
//
//  Created by Francis Jemuel Bergonia on 05/05/2018.
//  Copyright © 2018 Francis Jemuel Bergonia. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
//        emailTextField.layer.addSublayer(bottomlayer)
//        passwordTextField.layer.addSublayer(bottomlayer)
        
    }



}
