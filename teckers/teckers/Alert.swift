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
    private var title = ""
    private var massage = ""
    
    init(title: String, massage: String) {
        self.title = title
        self.massage = massage
    }
    
    func showOK() -> UIAlertController {
        let alert = UIAlertController(title: self.title, message: self.massage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        return alert
    }
    
    func showActionSheetAssistance(id: String, success : @escaping (_ response: Int) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: self.title, message: self.massage, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Si", style: .default , handler: { (UIAlertAction) in
            Session.setSessionAssistanceRequest(id: id, success: { response in
                if NetworkAnswers.ok.rawValue == response {
                    success(response)
                }
            })
        }))
        alert.addAction(UIAlertAction(title: "No🙁", style: .default , handler: nil))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        return alert
    }
}
