//
//  PrincipalNavigationBar.swift
//  teckers
//
//  Created by Maggie Mendez on 9/5/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class MainNavigationItem: UINavigationItem {
    
    override init(title: String) {
        super.init(title: title)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    func setupUI(){
        
        let icon = UIImage(named: Image.LogoBar.rawValue)
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        
        let hamburgerButton =  UIBarButtonItem(image:UIImage(named: Image.Menu.rawValue), style: .plain, target: self, action: #selector(logOut))
        
        self.leftBarButtonItems = [hamburgerButton]
        self.titleView = imageView
//        setupMessages()
    }
    func setupMessages(){
        
        let addButton =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapButton))
        self.rightBarButtonItem = addButton
    }
    
    @objc func tapButton(){
        print("tap")
    }
    @objc func logOut(){
        let authentication = Authentication()
        authentication.signOut(onSuccess: {
            guard let window = UIApplication.shared.delegate?.window else { return }
            let storyboard = UIStoryboard(name: Storyboards.baseStoryboard.rawValue, bundle: Bundle.main)
            if let logout = storyboard.instantiateViewController(withIdentifier: Views.LoginControllerID.rawValue) as? UINavigationController{
                window?.rootViewController = logout
            }
        }) { (error) in
            guard let window = UIApplication.shared.delegate?.window else { return }
            let alertAction = Alert(title: "Error", massage: error?.localizedDescription ?? "")
            window?.rootViewController?.present(alertAction.showOK(), animated: true, completion: nil)
        }
    }
}
