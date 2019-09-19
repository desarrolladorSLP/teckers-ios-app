//
//  MessagesRequest.swift
//  teckers
//
//  Created by Maggie Mendez on 9/13/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

struct MessagesService {
    
    static func backendMessagesRequest(onFailure failure: @escaping (_ error: Error) -> Void, success : @escaping (_ JSON : [String : Any]) -> Void){
        NetworkHandler.request(url: MessagesRouter.getMessages , onFailure: failure,  onSucess: success)
    }
    
    static func getMessages(priority: Bool, onFailure failure: @escaping (_ error: Error) -> Void, success : @escaping (_ messages:[MessagesUser]) -> Void ){
        NetworkHandler.request(url: MessagesRouter.getMessages, onFailure: failure) { (response) in
            let list = MessagesLists()
            list.readMessages(JSON: response, priority: priority)
            success(list.getMessagesList())
        }
    }
}
