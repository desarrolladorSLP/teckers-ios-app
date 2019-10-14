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
    
    static func request(url : URLRequestConvertible, onSucess success : @escaping (DataResponse<Any>) -> Void,  onFailure failure: ((_ error: Error) -> Void)?){
        if !isConnected(){
            NetworkError.instance.getAction(for: .noInternet)()
            return
        }
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(_):
                success(response)
            case .failure(_):
                guard let statusCode = response.response?.statusCode else{
                    NetworkError.instance.getAction(for: .requestTimeOutXcode)()
                    return
                }
                NetworkError.instance.getAction(for: NetworkAnswers(value: statusCode) ?? .badRequest )()
            }
        }
    }
    
    static func requestImage(url : URL, completionHandler: @escaping (Data?,Error?) -> Void){
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completionHandler(data, error)
            }.resume()
    }
    
    static func isConnected() -> Bool{
        if let isConnected = NetworkReachabilityManager()?.isReachable {
            return isConnected
        }
        return false
    }
}
