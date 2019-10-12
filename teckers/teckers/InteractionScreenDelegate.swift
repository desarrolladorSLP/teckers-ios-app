//
//  navegationDelegate.swift
//  teckers
//
//  Created by Maggie Mendez on 8/14/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import UIKit

protocol InteractionScreenDelegate {
    func dismiss()
    func goTo(with segueIdentifier: Segues)
    func error(message : String)
}
extension InteractionScreenDelegate where Self: UIViewController {
    func dismiss(){
        self.dismiss(animated: true)
    }
    func goTo(with segueIdentifier: Segues) {
       self.performSegue(withIdentifier: segueIdentifier.rawValue, sender: nil)
    }
       
    func error(message : String){
       let alertNotification = Alert(title: "Error", massage: message, type: 0)
       present(alertNotification.show(), animated: true, completion: nil)
    }
}
