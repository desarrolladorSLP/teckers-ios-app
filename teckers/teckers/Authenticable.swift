//
//  Authenticable.swift
//  teckers
//
//  Created by Maggie Mendez on 8/15/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

protocol Authenticable {
    func singOut() -> (flag: Bool, error: String) 
}
