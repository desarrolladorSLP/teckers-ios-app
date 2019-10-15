//
//  Deliverable.swift
//  teckersDeliverable
//
//  Created by Maggie Mendez on 10/8/19.
//  Copyright © 2019 Maggie Mendez. All rights reserved.
//

import Foundation

struct Deliverable: Codable {
    let title: String
    let description: String
    let status: Int
    let resources: [String]
    
    enum CodingKeys: String, CodingKey{
        case title, description, status, resources
    }
}
