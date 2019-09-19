//
//  User.swift
//  teckers
//
//  Created by Maggie Mendez on 8/24/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
class User : Codable {
    
    let name : String
    let imageURL : String
    
    internal init(name: String, imageURL: String) {
        self.name = name
        self.imageURL = imageURL
    }
}
