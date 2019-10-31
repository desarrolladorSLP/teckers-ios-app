//
//  Deliverable.swift
//  teckersDeliverable
//
//  Created by Maggie Mendez on 10/8/19.
//  Copyright © 2019 Maggie Mendez. All rights reserved.
//

import Foundation

struct Deliverable: Decodable {
    let id: String
    let title: String
    let description: String?
    let status: statusDeliverables?
    let date: Date?
    
    enum CodingKeys: String, CodingKey{
        case id, title, description, status, date = "dueDate"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        let dateString = try container.decode(String.self, forKey: .date)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/MM/dd"
        date = dateFormater.date(from: dateString)
        let statusNumber = try container.decode(String.self, forKey: .status)
        status = statusDeliverables(rawValue: statusNumber)
        description = nil
    }
    
}
