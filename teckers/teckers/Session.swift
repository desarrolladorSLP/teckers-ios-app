//
//  Session.swift
//  teckers
//
//  Created by Ricardo Granja on 8/30/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import Alamofire

struct Session: Codable {
    
    var type: String = ""
    var date: String = ""
    var subject: String = ""
    var location: String = ""
    var startTime: String = ""
    var endTime: String = ""
    var directions: String = ""
    
    init(JSON: [String: Any]) {
        self.type = JSON["type"] as? String ?? ""
        self.date = JSON["date"] as? String ?? ""
        self.subject = JSON["subject"] as? String ?? ""
        self.location = JSON["location"] as? String ?? ""
        self.startTime = JSON["startTime"] as? String ?? ""
        self.endTime = JSON["endTime"] as? String ?? ""
        self.directions = JSON["directions"] as? String ?? ""
    }
    
    static func backendSessionsRequest(year: Int, month: Int, success : @escaping (_ JSON : [[String : Any]]) -> Void) {
        Alamofire.request(SessionRouter.getSessions(year: year, month: month)).responseJSON{ response in
            if let _ = response.error {
                //self.delegate?.error(message: Error.localizedDescription)
            }
            else if let jsonResponseBackend = response.value as? [[String:Any]] {
                success(jsonResponseBackend)
            }
        }
    }
}
