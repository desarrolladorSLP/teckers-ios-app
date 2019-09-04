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
    private var title: String
    private var massage: String
    private var type: Int
    private let alert: UIAlertController
    
    init(title: String, massage: String, type: Int) {
        self.title = title
        self.massage = massage
        self.type = type
        alert = UIAlertController(title: self.title, message: self.massage, preferredStyle: UIAlertController.Style.alert)
    }
    
    func defineButtons(type: TypeButtons, handlers : [(UIAlertAction) -> Void]){
        switch type{
        case .OK:
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handlers[0]))
            fallthrough
        case .OkCancel:
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: handlers[1]))
        case .Reload:
            alert.addAction(UIAlertAction(title: "Reload", style: UIAlertAction.Style.default, handler: handlers[0]))
        case .TryLater:
            alert.addAction(UIAlertAction(title: "Try later", style: UIAlertAction.Style.default, handler: handlers[0]))
        }
    }
    
    func show() -> UIAlertController {
        
        switch self.type {
        case 0:
            alert = UIAlertController(title: self.title, message: self.massage, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        case 1:
            alert = UIAlertController(title: self.title, message: self.massage, preferredStyle: .actionSheet)

            alert.addAction(UIAlertAction(title: "Si", style: .default , handler: { (UIAlertAction) in
                print("1")
            }))
            alert.addAction(UIAlertAction(title: "No🙁", style: .default , handler: { (UIAlertAction) in
                print("2")
            }))
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (UIAlertAction) in
                print("Bye")
            }))
        default:
            print("default")
        }

        return alert
    }
}
