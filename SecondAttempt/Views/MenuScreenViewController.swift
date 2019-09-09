//
//  MenuScreenViewController.swift
//  SecondAttempt
//
//  Created by David Mann on 7/1/19.
//  Copyright © 2019 David Mann. All rights reserved.
//

import UIKit

class MenuScreenViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
