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
        
        guard let email = Auth.auth().currentUser?.email else { return }
        emailLabel.text = email
        emailLabel.textAlignment = .center
        
        signOutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        signOutButton.setTitle("Sign Out", for: UIControl.State.normal)
        signOutButton.backgroundColor = .red
        signOutButton.setTitleColor(.white, for: UIControl.State.normal)
        signOutButton.layer.cornerRadius = 20
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        //GIDSignIn.sharedInstance()?.signOut()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
