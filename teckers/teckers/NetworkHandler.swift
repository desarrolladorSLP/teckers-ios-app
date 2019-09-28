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
    
    static func request(url : URLRequestConvertible, onSucess success : @escaping (_ JSON : [String : Any]) -> Void,  onFailure failure: @escaping (_ error: Error) -> Void){
        Alamofire.request(url).responseJSON{ response in
            if let Error = response.error {
                failure(Error)
            }
            else if let jsonResponseBackend = response.value as? [String:Any] {
                success(jsonResponseBackend)
            }
        }
    }
    
    static func requestImage(url : URL, completionHandler: @escaping (Data?,Error?) -> Void){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completionHandler(data, error)
            }.resume()
    }
}
