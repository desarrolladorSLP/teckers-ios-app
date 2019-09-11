//
//  PrincipalNavigationBar.swift
//  teckers
//
//  Created by Maggie Mendez on 9/5/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class PrincipalNavigationItem: UINavigationItem {
    
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
        
        let hamburgerButton =  UIBarButtonItem(image:UIImage(named: Image.Menu.rawValue), style: .plain, target: self, action: #selector(tapButton))
        
        self.leftBarButtonItems = [hamburgerButton]
        self.titleView = imageView
        setupMessages()
    }
    func setupMessages(){
        let addButton =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapButton))
        self.rightBarButtonItem = addButton
    }
    
    @objc func tapButton(){
        print("Tap Button")
    }
}
