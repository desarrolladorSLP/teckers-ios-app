//
//  BatchTecker.swift
//  teckers
//
//  Created by Maggie Mendez on 26/11/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct BatchTeckers: Tecker, Codable {
    let teckerId: String
    let name: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case teckerId, name, imageURL = "pictureUrl"
    }
}
