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
    
    private var authentification: Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authentification = Authentication()
        authentification?.setDelegate(self, onFailure: { (error) in
            if let signOutError = error {
                let alertAction = Alert(title: "Error", massage: signOutError.localizedDescription, type: 0)
                self.present(alertAction.show(), animated: true, completion: nil)
            }
        })
        
        if(GIDSignIn.sharedInstance()?.currentUser != nil){
            self.performSegue(withIdentifier: Segues.toHome.rawValue, sender: nil)
        }
        GIDSignIn.sharedInstance().uiDelegate = self
        signUI()
    }
    
    func signUI() {
        signInButton.layer.cornerRadius = 20
        yellowView.layer.cornerRadius = 40
    }
}

extension LoginViewController : InteractionScreenDelegate {
    
    func goTo(with segueIdentifier: Segues) {
        self.performSegue(withIdentifier: segueIdentifier.rawValue, sender: nil)
    }
    
    func error(message : String){
        let alertNotification = Alert(title: "Error", massage: message, type: 0)
        present(alertNotification.show(), animated: true, completion: nil)
    }
    
}
