//
//  TokenKey.swift
//  teckers
//
//  Created by Maggie Mendez on 8/16/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import KeychainAccess

public class TokenKey{
    
    private let keychain : Keychain
    
    internal init() {
        let serverURL = RoadURL.baseURL.rawValue
        self.keychain = Keychain(server : serverURL, protocolType: .https)
    }
    func setToken(key: String, with token : String) throws {
        return try keychain.set(token, key: key)
    }
    func getToken(user: String) throws -> String? {
        var token: String?
        do {
            if let token_aux = try keychain.get(user) {
                token = token_aux
            }
        }
        catch{
            throw error
        }
       return token
    }
    func getAllTokens() -> [[String : Any]]{
        return keychain.allItems()
    }
    func removeTocken(user: String) throws {
        return try keychain.remove(user)
    }
}
