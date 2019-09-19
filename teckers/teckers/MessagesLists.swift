//
//  MessagesLists.swift
//  teckers
//
//  Created by Maggie Mendez on 9/8/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

class MessagesLists {
    
    private var listMessages : [MessagesUser]
//    private let backendInteraction : MessagesService
    init() {
        listMessages = []
        
//        MessagesService.backendMessagesRequest(onFailure: failure) { (response) in
//            self.readMessages(JSON: response, priority: priority)
//            success(self.ListMessages)
//        }
    }
    func getMessagesList() -> [MessagesUser]{
        return listMessages
    }

    func readMessages(JSON : [String: Any], priority : Bool) {
        let listJSON :  [Any]?
        if priority{
            listJSON = JSON[MessagesKeys.highPriority.rawValue] as? [ Any]
        }
        else {
            listJSON = JSON[MessagesKeys.lowPriority.rawValue] as? [Any]
        }
        guard let list = listJSON else{
           return
        }
        pullAllMessagesOf(priority: priority, in: list)
    }
    
    func pullAllMessagesOf(priority: Bool, in list: [Any]){
        for listItem  in list {
            if let item = listItem as? [String : Any] {
                let userMessage = MessagesUser(item: item, priority: priority)
                listMessages.append(userMessage)
            }
        }
    }
}
