//
//  Message.swift
//  teckers
//
//  Created by Maggie Mendez on 8/23/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import UIKit

class Message {
    var subject : String
    var text : String
    var date : String
    var priority : Bool
    
    init(subject : String, message : String, date: String, priority: Bool) {
        self.subject = subject
        self.text = message
        self.date = date
        self.priority = priority
    }
}
