//
//  Session.swift
//  teckers
//
//  Created by Ricardo Granja on 8/30/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct Session: Codable {
    
    var date: String = ""
    var localization: String = ""
    var name: String = ""
    var schedule: String = ""
    var subject: String = ""
    var generalDirections: String = ""
    //var status
    
    init(JSON: [String: Any]) {
        self.date = JSON["date"] as? String ?? ""
        self.localization = JSON["localization"] as? String ?? ""
        self.name = JSON["localization"] as? String ?? ""
        self.schedule = JSON["schedule"] as? String ?? ""
        self.subject = JSON["subject"] as? String ?? ""
        self.generalDirections = JSON["generalDirections"] as? String ?? ""
    }
}
