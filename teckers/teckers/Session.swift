//
//  Session.swift
//  teckers
//
//  Created by Ricardo Granja on 8/30/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct Session: Codable {
    
    var type: String = ""
    var startDate: String = ""
    var subject: String = ""
    var location: String = ""
    var startTime: String = ""
    var endTime: String = ""
    var directions: String = ""
    
    init(JSON: [String: Any]) {
        self.type = JSON["type"] as? String ?? ""
        self.startDate = JSON["startDate"] as? String ?? ""
        self.subject = JSON["subject"] as? String ?? ""
        self.location = JSON["location"] as? String ?? ""
        self.startTime = JSON["startTime"] as? String ?? ""
        self.endTime = JSON["endTime"] as? String ?? ""
        self.directions = JSON["directions"] as? String ?? ""
    }
}
