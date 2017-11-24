//
//  LoginViewController.swift
//  KRTestTask
//
//  Created by Admin on 22.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    let receiveToken = ReceiveToken()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginButton.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        self.receiveToken.doOAuthTrello(viewController: self)
    }
    
 
}

