//
//  CreateProfile2ViewController.swift
//  SecondAttempt
//
//  Created by David Mann on 8/13/19.
//  Copyright © 2019 David Mann. All rights reserved.
//

import UIKit

class CreateProfile2ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var buttonCol: [UIButton]!
    @IBOutlet var imageView: UIImageView!
//    @IBOutlet var chooseBuuton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var pickerOptions : [[String]] = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imagePicker.delegate = self
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        
    }
    
    @IBAction func buttonpressed(_ sender: Any) {
        print("selected the size")
       
        for button in buttonCol {
            if button.tag <= (sender as! UIButton).tag {
                button.backgroundColor = UIColor.green
                button.layer.borderWidth = 1
            }
        }
    }
    
    @IBAction func btnClicked() {
    print("button pressed")
//    if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//    print("Button capture")
//
//    imagePicker.delegate = self
//    imagePicker.sourceType = .savedPhotosAlbum
//    imagePicker.allowsEditing = false
//
//    present(imagePicker, animated: true, completion: nil)
//        }
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
}
