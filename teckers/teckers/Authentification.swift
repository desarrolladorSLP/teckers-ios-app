//
//  Authentification.swift
//  teckers
//
//  Created by Ricardo Granja on 8/8/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn
import Alamofire

class Authentification: NSObject, GIDSignInDelegate  {
    
    var delegate : InteractionScreenDelegate?
    
    override init(){
        super.init()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    static func singOut() -> (flag: Bool, error: String) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance()?.signOut()
            return (false, "")
        } catch let signOutError as NSError {
            return (true, signOutError.localizedDescription)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let Error = error {
            self.delegate?.error(message: Error.localizedDescription)
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let Error = error {
                self.delegate?.error(message: Error.localizedDescription)
                return
            }
            self.getTockenRefresh()
        }
    }
    
    private func getTockenRefresh() {
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let Error = error {
                self.delegate?.error(message: Error.localizedDescription)
                return;
            }
            self.alamonfireRequest(with: idToken)
        }
    }
    
    func alamonfireRequest(with idToken: String?) {
        Alamofire.request(AuthRouter.auth(token: idToken!)).responseJSON { response in
            if let Error = response.error {
                self.delegate?.error(message: Error.localizedDescription)
            }
            else if let jsonResponseBackend = response.value as? [String:Any] {
                let authFromBackend = AuthenticationInfo(JSON: jsonResponseBackend)
                self.delegate?.goTo(with: RoadStoryboards.toHome.rawValue)
            }
        }
    }
}
