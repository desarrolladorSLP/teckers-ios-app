//
//  UserInformation.swift
//  teckers
//
//  Created by Ricardo Granja on 23/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

class UserInformation {
    static let shared = UserInformation()
    var email: String?
    var name: String?
    var roles: [String]?
    
    init() {
    }
    
    func setInformation(infoUser: AuthenticationInfo) {
        self.email = infoUser.email
        self.name = infoUser.name
        self.roles = infoUser.roles!
    }
}
