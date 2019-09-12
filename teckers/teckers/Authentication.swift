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

class Authentication: NSObject, GIDSignInDelegate, Authenticable {
    
    private var delegate : InteractionScreenDelegate?
    private var onFailure : ((_ error: Error?) -> Void)?
    private var TokenDiccionary = Token()
    
    override init( ){
        super.init()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    func setDelegate(_ delegate : InteractionScreenDelegate, onFailure failure: @escaping (_ error: Error?) -> Void){
        self.onFailure = failure
        self.delegate = delegate
    }
    
    func signOut(onSuccess success: @escaping () -> Void,
                 onFailure failure: @escaping (_ error: Error?) -> Void)  {
        onFailure = failure
        do {
            let firebaseAuth = Auth.auth()
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance()?.signOut()
            success()
        } catch let signOutError as NSError {
            failure (signOutError)
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
            if let token = idToken {
                self.backendAuthenticationRequest(with: token)
            }
        }
    }
    
    func backendAuthenticationRequest(with idToken: String) {
        Alamofire.request(AuthRouter.auth(token: idToken)).responseJSON {
            response in
            if let Error = response.error {
                self.delegate?.error(message: Error.localizedDescription)
            }
            else if let jsonResponseBackend = response.value as? [String:Any] {
                do{
                    let authFromBackend = AuthenticationInfo(JSON: jsonResponseBackend)
                    try self.saveToken(accessToken: authFromBackend.access_token, and: idToken)
                    self.delegate?.goTo(with: Segues.toHome)
                }
                catch{
                    self.onFailure!(error)
                }
            }
        }
    }
    func saveToken(accessToken: String, and refreshToken : String) throws{
        do{
            try self.TokenDiccionary.setToken(key: Constant.refreshToken.rawValue , with : refreshToken)
            try self.TokenDiccionary.setToken(key: Constant.refreshToken.rawValue, with : accessToken)
        }
        catch{
            throw error
        }
    }
}
