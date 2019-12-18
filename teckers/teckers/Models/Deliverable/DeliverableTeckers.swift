//
//  DeliverableParent.swift
//  teckers
//
//  Created by Ricardo Granja on 24/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct DeliverableTeckers: Tecker, Codable {
    let teckerId: String
    let name: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case teckerId, name, imageURL = "imageUrl"
    }
}
