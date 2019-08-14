//
//  ViewController.swift
//  teckers
//
//  Created by Haydee Rodriguez on 11/07/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import Alamofire

class ViewController: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var signInButton: GIDSignInButton! //Google Button
    
    var authentification: Authentification?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authentification = Authentification()
        if(GIDSignIn.sharedInstance()?.currentUser != nil){
            self.performSegue(withIdentifier: Road.toHome.rawValue, sender: nil)
        }
        GIDSignIn.sharedInstance().uiDelegate = self
        signUI()
    }
    
    func signUI(){
        signInButton.layer.cornerRadius = 20
        yellowView.layer.cornerRadius = 40
    }
}
