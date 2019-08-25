//
//  PrincipalNavigationItem.swift
//  
//
//  Created by Maggie Mendez on 8/24/19.
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
        let icon = UIImage(named: "Logo-9")
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        
        let hamburgerButton =  UIBarButtonItem(image:UIImage(named: "menu-rounded"), style: .plain, target: self, action: #selector(tapButton))
        
        self.leftBarButtonItem = hamburgerButton
        self.titleView = imageView
    }
    
    @objc func tapButton(){
        print("Tap Button")
    }
}
