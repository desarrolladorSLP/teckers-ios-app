//
//  NetworkHandler.swift
//  teckers
//
//  Created by Maggie Mendez on 9/18/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkHandler {
    
    private init(){
    }
    
    static func request(url : URLRequestConvertible,  onFailure failure: @escaping (_ error: Error) -> Void, onSucess success : @escaping (_ JSON : [String : Any]) -> Void){
        Alamofire.request(url).responseJSON{ response in
            if let Error = response.error {
                failure(Error)
            }
            else if let jsonResponseBackend = response.value as? [String:Any] {
                success(jsonResponseBackend)
            }
        }
    }
}
