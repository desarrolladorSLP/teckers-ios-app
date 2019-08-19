//
//  Authenticable.swift
//  teckers
//
//  Created by Maggie Mendez on 8/15/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

protocol Authenticable {
    func signOut(onSuccess success: @escaping () -> Void,
                 onFailure failure: @escaping (_ error: Error?) -> Void)
}
