//
//  MessagesRequest.swift
//  teckers
//
//  Created by Maggie Mendez on 9/13/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct MessagesService {
    
    static func backendMessagesRequest( success : @escaping (_ JSON : [String : Any]) -> Void, onFailure failure: @escaping (_ error: Error) -> Void){
        NetworkHandler.request(url: MessagesRouter.getMessages , onSucess: success, onFailure: failure)
    }
    
    static func getMessages(priority: Bool, success : @escaping (_ messages:[MessagesUser]) -> Void ,onFailure failure: @escaping (_ error: Error) -> Void){
        NetworkHandler.request(url: MessagesRouter.getMessages, onSucess: { (response) in
            let list = MessagesLists()
            list.readMessages(JSON: response, priority: priority)
            success(list.getMessagesList())
        }, onFailure: failure) 
    }
}
