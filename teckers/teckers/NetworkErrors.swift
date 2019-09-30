//
//  NetworkErrors.swift
//  teckers
//
//  Created by Maggie Mendez on 9/26/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import UIKit

class NetworkError{
    static let instance = NetworkError()
    
    private var dictionary: [TypesNetworkErrors: (Error) -> Void]
    init() {
        dictionary = [:]
        dictionary[TypesNetworkErrors.badRequest] = {error in
            let alertAction = Alert(title: "Error", massage: "Pagina No Encontrada" , type: 0)
            if let topController = UIApplication.shared.keyWindow?.rootViewController{
                if let presentController = topController.presentedViewController {
                    presentController.present(alertAction.show(), animated: true, completion: nil)
                }
            }
        }
    }
    func appendActionToError(for error: TypesNetworkErrors, toDo closure: @escaping (Error) -> Void ){
        dictionary[error] = closure
    }
    func getAction( for error: TypesNetworkErrors) -> ((Error) -> Void)?{
        return dictionary[error]
    }
}
