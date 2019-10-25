//
//  DeliverableParent.swift
//  teckers
//
//  Created by Ricardo Granja on 24/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

import Foundation

struct DeliverableParent: Codable {
    let teckerId: String
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case teckerId, name, imageUrl
    }
}
