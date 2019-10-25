//
//  HeaderAuthentication.swift
//  teckers
//
//  Created by Ricardo Granja on 9/20/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

enum Header: String {
    case Basic = "Basic "
    case Bearer
    case Authorization
    case Accept = "application/json"
    case Bearer = "Bearer"
}
