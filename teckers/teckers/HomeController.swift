//
//  HomeController.swift
//  teckers
//
//  Created by Maggie Mendez on 8/23/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var addMessageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        addMessageButton.backgroundColor = .purple
        addMessageButton.layer.cornerRadius = addMessageButton.frame.height / 2
        addMessageButton.tintColor = .white
    }
}
