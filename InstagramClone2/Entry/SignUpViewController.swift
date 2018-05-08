//
//  SignUpViewController.swift
//  InstagramClone2
//
//  Created by Francis Jemuel Bergonia on 05/05/2018.
//  Copyright © 2018 Francis Jemuel Bergonia. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    var selectedImage: UIImage?
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.bottomActionSheetPressed))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
    }

    
    @IBAction func dismiss_OnClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Registration Successful for \(user)")
                
                let uid = user?.uid
                let storageRef = Storage.storage().reference(forURL: "gs://hobbygram-62da8.appspot.com").child("profile_image").child(uid!)
                if let profileImage = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImage, 0.1) {
                    storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            print(error!.localizedDescription)
                            //return
                        }
                        
                        let profileImageUrl = metadata?.downloadURL()?.absoluteString
                        //Firebase Database
                        let ref = Database.database().reference()
                        let usersReference = ref.child("users")
                        let newUserReference = usersReference.child(uid!)
                        newUserReference.setValue(["username": self.usernameTextField.text!, "email": self.emailTextField.text!, "profileImageUrl": profileImageUrl])
                        print("description \(newUserReference.description())")
                        
                    })
                }

            }
        }
    }
    
    
    //MARK: Bottom ActionSheet
    @objc func bottomActionSheetPressed() {
        let alert = UIAlertController(title: nil, message: "Get an image for Profile", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Select from Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.selectFromGallery()}))
        alert.addAction(UIAlertAction(title: "Capture an image", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.getAnImage()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: PhotoLibrary Functions
    func selectFromGallery() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    //MARK: Camera Functions
    func getAnImage() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraImagePickerController = UIImagePickerController()
            cameraImagePickerController.sourceType = .camera
            cameraImagePickerController.delegate = self
            present(cameraImagePickerController, animated: true, completion: nil)
        }
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {fatalError("Expected a dictionary containing an image, but was provided the following: \(info)") }
        self.selectedImage = image
        self.profileImage.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
