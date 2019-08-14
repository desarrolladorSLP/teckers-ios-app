//
//  SignedInViewController.swift
//  teckers
//
//  Created by Maggie Mendez on 7/24/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignedInViewController: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    func setUpUI(){
        
        guard let email = Auth.auth().currentUser?.email else{
            return
        }
        emailLabel.text = email
        emailLabel.textAlignment = .center

        signOutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        signOutButton.setTitle("Sign Out", for: UIControl.State.normal)
        signOutButton.backgroundColor = .red
        signOutButton.setTitleColor(.white, for: UIControl.State.normal)
        signOutButton.layer.cornerRadius = 20
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        let result = Authentification.singOut()
        
        if result.flag {
            let alertAction = Alert(title: "Error", massage: result.error, type: 0)
        
            self.present(alertAction.show(), animated: true, completion: nil)
            return
        }
        self.navigationController?.popViewController(animated: true)
    }    
}
