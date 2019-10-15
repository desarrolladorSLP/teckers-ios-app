//
//  Session.swift
//  teckers
//
//  Created by Ricardo Granja on 8/30/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct Session: Codable {
    
    var id: String = ""
    var type: String = ""
    var date: Date?
    var subject: String = ""
    var location: String = ""
    var startTime: Date?
    var endTime: Date?
    var directions: String = ""
    
    init(JSON: [String: Any]) {
        
        self.id = JSON["id"] as? String ?? ""
        self.type = JSON["type"] as? String ?? ""
        self.date = DateCalendar.stringToDate(to: JSON["date"] as? String ?? "")
        self.subject = JSON["subject"] as? String ?? ""
        self.location = JSON["location"] as? String ?? ""
        self.startTime = DateCalendar.stringToTime(to: JSON["startTime"] as? String ?? "")
        self.endTime = DateCalendar.stringToTime(to: JSON["endTime"] as? String ?? "")
        self.directions = JSON["directions"] as? String ?? ""
    }
    
    static func getSessionsRequest(year: Int, month: Int, success : @escaping (_ JSON : [[String : Any]]) -> Void, failure : @escaping (Error) -> Void) {
        NetworkHandler.request(url: SessionRouter.getSessions(year: year, month: month), onSucess: { (response) in
            if let jsonResponseBackend = response.value as? [[String:Any]] {
                success(jsonResponseBackend)
            }
        }, onFailure: failure)
    }
    
    static func setSessionAssistanceRequest(id: String, success: @escaping (_ response : Int) -> Void) {
        NetworkHandler.request(url: SessionRouter.setSessionAssistance(id: id), onSucess: { (response) in
            success(response.response?.statusCode ?? 0)
        }, onFailure: nil)
    }
}
