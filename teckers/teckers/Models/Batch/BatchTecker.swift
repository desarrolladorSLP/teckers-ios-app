//
//  BatchTecker.swift
//  teckers
//
//  Created by Maggie Mendez on 26/11/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct BatchTeckers: Codable {
    let teckerId: String
    let name: String
    let pictureUrl: String
    
    enum CodingKeys: String, CodingKey {
        case teckerId, name, pictureUrl
    }
}
