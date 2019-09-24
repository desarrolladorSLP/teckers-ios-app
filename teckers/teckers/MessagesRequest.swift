//
//  MessagesRequest.swift
//  teckers
//
//  Created by Maggie Mendez on 9/13/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import Alamofire

class MessagesRequest {
    
    
    var failure : (_ error: Error) -> Void
    internal init(onFailure failure: @escaping (_ error: Error) -> Void) {
        self.failure = failure 
    }
    
    func backendMessagesRequest(success : @escaping (_ JSON : [String : Any]) -> Void){
        Alamofire.request(MessagesRouter.getMessages).responseJSON{ response in
            if let Error = response.error {
                self.failure( Error)
            }
            else if let jsonResponseBackend = response.value as? [String:Any] {
                success(jsonResponseBackend)
            }
        }
    }
}
