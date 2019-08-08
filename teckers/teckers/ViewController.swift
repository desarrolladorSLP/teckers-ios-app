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

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var signInButton: GIDSignInButton! //Google Button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        signUI()
    }
    
    func signUI(){
        signInButton.layer.cornerRadius = 20
        yellowView.layer.cornerRadius = 40
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let Error = error {
            print("Error: \(Error.localizedDescription)")
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                if let error = error {
                    print(error)
                    return;
                }
                AF.request(AuthRouter.auth(token: idToken!)).responseJSON { response in
                    if let error = response.error {
                        print("Error: \(error)")
                    } else if let jsonResponseBackend = response.value as? [String:Any] {
                        let authFromBackend = AuthentificationInfo(JSON: jsonResponseBackend)
                    }
                }
            }
        }
        self.performSegue(withIdentifier: "toHome", sender: nil)
    }
}
