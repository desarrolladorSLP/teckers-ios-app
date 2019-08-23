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
    var message = String()
    var image = UIImage()
    var date = Date()
    
    init(message : String, image : UIImage, date: Date) {
        self.message = message
        self.image = image
        self.date = date
    }
}
