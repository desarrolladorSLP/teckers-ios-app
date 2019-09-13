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
        Alamofire.request(AuthRouter.auth(token: idToken)).validate(statusCode: 200..<300).responseJSON {
            response in
            if let Error = response.error {
                self.delegate?.error(message: Error.localizedDescription)
            }
            else if let jsonResponseBackend = response.value as? [String:Any] {
                self.parseJSONfromBackend(jsonResponse: jsonResponseBackend, with: idToken)
                self.delegate?.goTo(with: Segues.toHome)
                print(idToken)
            }
        }
    }
    func parseJSONfromBackend(jsonResponse: [String : Any], with token: String){
        do{
            let authFromBackend = AuthenticationInfo(JSON: jsonResponse)
            try self.saveToken(accessToken: authFromBackend.access_token, and: token)
            self.delegate?.goTo(with: Segues.toHome)
        }
        catch{
            self.onFailure!(error)
        }
    }
    
    func backendMessagesRequest(success : @escaping (_ JSON : [String : Any]) -> Void){
        Alamofire.request(MessagesRouter.getMessages).responseJSON{ response in
            if let Error = response.error {
                self.delegate?.error(message: Error.localizedDescription)
            }
            else if let jsonResponseBackend = response.value as? [String:Any] {
                success(jsonResponseBackend)
            }
        }
    }
    func saveToken(accessToken: String, and refreshToken : String) throws{
        do{
            try self.TokenDiccionary.setToken(key: TokenKeys.RefreshToken.rawValue , with : refreshToken)
            try self.TokenDiccionary.setToken(key: TokenKeys.AccessToken.rawValue, with : accessToken)
        }
        catch{
            throw error
        }
    }
}
