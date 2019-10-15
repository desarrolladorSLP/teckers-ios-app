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
    
    func setupUI() {
        let icon = UIImage(named: Image.LogoBar.rawValue)
        let imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit
        
        self.titleView = imageView
    }

}
