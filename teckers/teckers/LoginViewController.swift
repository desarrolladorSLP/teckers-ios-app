//
//  ViewController.swift
//  teckers
//
//  Created by Haydee Rodriguez on 11/07/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var signInButton: GIDSignInButton! //Google Button
    
    var authentification: Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authentification = Authentication()
        if(GIDSignIn.sharedInstance()?.currentUser != nil){
            self.performSegue(withIdentifier: RoadStoryboards.toHome.rawValue, sender: nil)
        }
        authentification?.delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        signUI()
    }
    
    func signUI() {
        signInButton.layer.cornerRadius = 20
        yellowView.layer.cornerRadius = 40
    }
}

extension LoginViewController : InteractionScreenDelegate{
    
    func goTo(with segueIdentifier: String) {
        self.performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    func error(message : String){
        let alertNotification = Alert(title: "Error", massage: message, type: 0)
        present(alertNotification.show(), animated: true, completion: nil)
    }
}
