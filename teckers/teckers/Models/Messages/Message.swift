//
//  Message.swift
//  teckers
//
//  Created by Maggie Mendez on 8/23/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import UIKit

class Message : Codable{
    var subject : String
    var text : String?
    var date : Date
    var priority : Bool
        
    init(subject : String, date: Date, priority: Bool) {
        self.subject = subject
        self.date = date
        self.priority = priority
    }
}
