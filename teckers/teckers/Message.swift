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
    var date : Date
    
    init(message : String, user : User, date: Date) {
        self.text = message
        self.date = date
    }
}
