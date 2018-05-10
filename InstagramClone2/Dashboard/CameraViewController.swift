//
//  CameraViewController.swift
//  InstagramClone2
//
//  Created by Republisys on 08/05/2018.
//  Copyright © 2018 Francis Jemuel Bergonia. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addPhotoImage(_ sender: Any) {
        bottomActionSheetPressed()
    }

    
    //MARK: Bottom ActionSheet
    
    func bottomActionSheetPressed() {
        let alert = UIAlertController(title: nil, message: "Get an image of your check", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Select from Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.selectFromGallery()}))
        alert.addAction(UIAlertAction(title: "Capture an image", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.getAnImage()}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

    
    //MARK: PhotoLibrary Functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {fatalError("Expected a dictionary containing an image, but was provided the following: \(info)") }
        self.photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
