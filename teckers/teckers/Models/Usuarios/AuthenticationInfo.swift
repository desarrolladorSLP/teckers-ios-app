//
//  AuthentificationInfo.swift
//  teckers
//
//  Created by Ricardo Granja on 8/13/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct AuthenticationInfo: Codable {
    var email: String = ""
    var access_token: String = ""
    var name: String = ""
    var tokenType: String = ""
    var validated: Int = 0
    var enabled: Int = 0
    var expiresIn: Int = 0
    var roles: [String]?
    
    init(JSON: [String: Any]) {
        self.email = JSON["email"] as? String ?? ""
        self.access_token = JSON["access_token"] as? String ?? ""
        self.name = JSON["name"] as? String ?? ""
        self.tokenType = JSON["tokenType"] as? String ?? ""
        self.validated = JSON["validated"] as? Int ?? 0
        self.enabled = JSON["enabled"] as? Int ?? 0
        self.expiresIn = JSON["expiresIn"] as? Int ?? 0
        self.roles = JSON["roles"] as? [String]
    }
}
