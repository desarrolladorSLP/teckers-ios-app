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
    var text : String
    var date : String
    var priority : Bool
    
    init(message : String, date: String, priority: Bool) {
        self.text = message
        self.date = date
        self.priority = priority
    }
}
