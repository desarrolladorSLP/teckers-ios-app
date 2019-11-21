//
//  DeliverableParentMentor.swift
//  teckers
//
//  Created by Ricardo Granja on 21/11/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct DeliverableParentMentor: Codable {
    let teckerId: String
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case teckerId, name, imageUrl
    }
}
