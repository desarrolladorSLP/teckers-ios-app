//
//  ViewController.swift
//  teckers
//
//  Created by Haydee Rodriguez on 11/07/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInButton: GIDSignInButton! //Google Button
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var authentification: Authentication?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authentification = Authentication()
        authentification?.setDelegate(self, onSuccess: { [weak self] in
            if self?.spinner?.isAnimating ?? false{
                self?.spinner.stopAnimating()
            }
        }) { [weak self](error) in
            if let signOutError = error {
                let alertAction = Alert(title: "Error", massage: signOutError.localizedDescription)
                self?.present(alertAction.showOK(), animated: true, completion: nil)
                if self?.spinner?.isAnimating ?? false{
                    self?.spinner.stopAnimating()
                }
            }
        }
        GIDSignIn.sharedInstance()?.presentingViewController = self
        signUI()
    }
    
    func signUI() {
        signInButton?.layer.cornerRadius = 20
        spinner?.hidesWhenStopped = true
        spinner?.transform = CGAffineTransform(scaleX: 2, y: 2);
        spinner?.style = .whiteLarge
    }
    @IBAction func tapDown(_ sender: Any) {
        spinner.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkError.instance.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let view = UIApplication.shared.windows[0].rootViewController?.children[0] as? LoginViewController{
            if let info = NetworkError.instance.getInformation(for: .unauthorized){
                DispatchQueue.main.async {
                    view.error(message: info.message)
                }
            }
        }
    }
}

extension LoginViewController : InteractionScreenDelegate {
    func goTo(with segueIdentifier: Segues) {
        if segueIdentifier == Segues.toHome {
            let storyboard = UIStoryboard(name: Storyboards.logedStoryboard.rawValue, bundle: Bundle.main)
            if let home = storyboard.instantiateViewController(withIdentifier: Views.principalNavigationController.rawValue) as? UINavigationController {
                UIApplication.shared.delegate?.window??.rootViewController = home
            }
            
        }
    }
}
