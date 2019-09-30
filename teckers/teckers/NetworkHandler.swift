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
            switch response.result{
            case .success(let succes):
                print("Exito:  \(succes)")
                if let jsonResponseBackend = response.value as? [String:Any] {
                    success(jsonResponseBackend)
                }
            case .failure(let error):
                print(error)
                
                switch response.response?.statusCode {
                case 503:
                    if let fail = NetworkError.instance.getAction(for: .badRequest){
                        fail(error)
                    }
                default:
                    failure(error)
                }
            }
//            if let Error = response.error {
//                failure(Error)
//            }
//            else if let jsonResponseBackend = response.value as? [String:Any] {
//                success(jsonResponseBackend)
//            }
//            switch response.response?.statusCode{
//                case 400:
//                    if let error = NetworkError.instance.getAction(for: .badRequest){
//                        error(response.error)
//                    }
//                case 500:
//                    print("\n\n\n\nError 500 - 599")
//                default:
//                    print("Error default ")
//            }
            
        }
    }
    
    static func requestImage(url : URL, completionHandler: @escaping (Data?,Error?) -> Void){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completionHandler(data, error)
            }.resume()
    }
}
