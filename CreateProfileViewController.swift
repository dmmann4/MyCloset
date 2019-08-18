//
//  CreateProfileViewController.swift
//  SecondAttempt
//
//  Created by David Mann on 7/7/19.
//  Copyright © 2019 David Mann. All rights reserved.
//

import UIKit
import Photos
import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import TextFieldEffects


class CreateProfileViewController: UIViewController,  UINavigationControllerDelegate {
    
    @IBOutlet private var textViewTest: [TextFieldEffects]!
    @IBOutlet private var passwordSignUp: [TextFieldEffects]!
    @IBOutlet private var confirmPassword: [TextFieldEffects]!
    @IBOutlet private var emailAddress: [TextFieldEffects]!
    
    
    @IBOutlet weak var button: UIButton!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    
    }
    
    @IBAction func createEmailProfileButtonPressed(_ sender: Any) {
        createUser(email: emailAddress.description, password: passwordSignUp.description)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func createUser(email: String, password: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let e = error{
                callback?(e)
                return
            }
            callback?(nil)
        }
    }
 
}
