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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkError.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let view = UIApplication.shared.windows[0].rootViewController?.children[0] as? LoginViewController{
            if let info = NetworkError.instance.getInformation(for: 401){
                DispatchQueue.main.async {
                    view.error(message: info.message)
                }
            }
        }
    }
}

extension LoginViewController : InteractionScreenDelegate {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func goTo(with segueIdentifier: Segues) {
        self.performSegue(withIdentifier: segueIdentifier.rawValue, sender: nil)
    }
    
    func error(message : String){
        let alertNotification = Alert(title: "Error", massage: message, type: 0)
        present(alertNotification.show(), animated: true, completion: nil)
    }
    
}
