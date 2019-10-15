//
//  AuthManager.swift
//  teckers
//
//  Created by Maggie Mendez on 8/15/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

class AuthManager {
    
    static func instance() -> Authenticable {
        return Authentication()
    }
}
