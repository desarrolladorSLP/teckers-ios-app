//
//  MessagesLists.swift
//  teckers
//
//  Created by Maggie Mendez on 9/8/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

class MessagesLists {
    var HighPriorityMessages : [MessagesUser]
    var LessPriorityMessages : [MessagesUser]
    
    var ListMessages : [MessagesUser]
    private let backendInteraction : Authentication
    init(success : @escaping (_ list : [MessagesUser]) -> Void, priority : Bool ) {
        ListMessages = []
        HighPriorityMessages = []
        LessPriorityMessages = []
        backendInteraction = Authentication()
        
        self.backendInteraction.backendMessagesRequest  { (response) in
            self.readMessages(JSON: response, priority: priority)
//            self.readMessages(JSON: response, priority: false)
            success(self.ListMessages)
        }
    }
    func readMessages(JSON : [String: Any], priority : Bool){
        let listJSON :  [Any]?
        if priority{
            listJSON = JSON[MessagesKeys.highPriority.rawValue] as? [ Any]
        }
        else {
            listJSON = JSON[MessagesKeys.lowPriority.rawValue] as? [Any]
        }
        guard let List = listJSON else{
           return
        }
        pullAllMessagesOf(priority: priority, in: List)
    }
    
    func pullAllMessagesOf(priority: Bool, in list: [Any]){
        for listItem  in list {
            if let item = listItem as? [String : Any] {
                let userMessage = MessagesUser(item: item, priority: priority)
                ListMessages.append(userMessage)
            }
        }
    }
}
