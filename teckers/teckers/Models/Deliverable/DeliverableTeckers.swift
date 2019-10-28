//
//  DeliverableParent.swift
//  teckers
//
//  Created by Ricardo Granja on 24/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

import Foundation

struct DeliverableTeckers: Codable {
    let teckerId: String
    let name: String
<<<<<<< HEAD
    let imageUrl: String?
=======
    let imageUrl: String
>>>>>>> Role Definition
    
    enum CodingKeys: String, CodingKey {
        case teckerId, name, imageUrl
    }
}
