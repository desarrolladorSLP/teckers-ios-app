//
//  Alert.swift
//  teckers
//
//  Created by Ricardo Granja on 8/12/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    var title = ""
    var massage = ""
    var type = -1
    
    init(title: String, massage: String, type: Int) {
        self.title = title
        self.massage = massage
        self.type = type
    }
    
    func show() -> UIAlertController {
        let alert = UIAlertController(title: self.title, message: self.massage, preferredStyle: UIAlertController.Style.alert)
        
        switch self.type {
        case 0:
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        default:
            print("default")
        }

        return alert
    }
}
