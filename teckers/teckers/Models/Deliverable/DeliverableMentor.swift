//
//  DeliverableMentor.swift
//  teckers
//
//  Created by Ricardo Granja on 27/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct DeliverableMentor: Codable {
    let teckerId: String
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case teckerId, name, imageUrl
    }
}
